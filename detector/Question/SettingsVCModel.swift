import UIKit

class SettingsViewModel {
   // var fetchedQuestions: [String] = []
    private let nameTest = OnlineNameTest()
    private let simpleBluetoothIO = BluetoothManager()
    var activityIndicator: UIActivityIndicatorView?
    static var objectId: String?
    static var name_test: String = ""
    static var fetchedQuestions: [String] = []
    var fetchedQuestionsCount: Int {
        return SettingsViewModel.fetchedQuestions.count
    }

  

    func question(at index: Int) -> String {
        return SettingsViewModel.fetchedQuestions[index]
    }

    func updateData(withObjectId objectId: String, tableView: UITableView!) {
        nameTest.fetchDataFromAPI(objectId: objectId, token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) {  [weak self] questions in

            DispatchQueue.main.async {
                if let fetchedQuestions = questions {
                    SettingsViewModel.fetchedQuestions = fetchedQuestions
                    tableView.reloadData()
                } else {
                    if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: SettingsViewModel.name_test) {
                        SettingsViewModel.fetchedQuestions = questionsArray
                    }
                    tableView.reloadData()
                }
                self?.activityIndicator?.stopAnimating()
                self?.activityIndicator?.removeFromSuperview()
            }
        }
    }

    func startTest() {
        AllTestViewModel.questions = SettingsViewModel.fetchedQuestions
    }
}
