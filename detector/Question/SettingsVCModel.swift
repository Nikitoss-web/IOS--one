import Foundation
import UIKit

class SettingsViewModel {
    var fetchedQuestions: [String] = []
    private let nameTest = OnlineNameTest()
    private let simpleBluetoothIO = BluetoothManager()
    private weak var activityIndicator: UIActivityIndicatorView?
    private weak var navigationController: UINavigationController?
    var name_test: String = ""
    var fetchedQuestionsCount: Int {
        return fetchedQuestions.count
    }

    init(activityIndicator: UIActivityIndicatorView, navigationController: UINavigationController) {
        self.activityIndicator = activityIndicator
        self.navigationController = navigationController
    }

    func question(at index: Int) -> String {
        return fetchedQuestions[index]
    }

    func updateData() {
        nameTest.fetchDataFromAPI(objectId: "", token: "") { [weak self] questions in
            guard let self = self else { return }

            DispatchQueue.main.async {
                if let fetchedQuestions = questions {
                    self.fetchedQuestions = fetchedQuestions
                    self.activityIndicator?.stopAnimating()
                    self.activityIndicator?.removeFromSuperview()
                } else {
                    if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: self.name_test) {
                        self.fetchedQuestions = questionsArray
                        self.activityIndicator?.stopAnimating()
                        self.activityIndicator?.removeFromSuperview()
                    }
                }
            }
        }
    }

    func startTest() {
        let storyboard = UIStoryboard(name: "AllTestStoryboard", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "AllTestVC") as? AllTestVC {
            vc.questions = fetchedQuestions
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
