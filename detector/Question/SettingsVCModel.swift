import UIKit

class SettingsViewModel {
    var activityIndicator: UIActivityIndicatorView?
    private let nameTest = OnlineNameTest()
    var fetchedQuestionsCount: Int {
        return Manager.fetchedQuestions.count
    }
    func question(at index: Int) -> String {
        return Manager.fetchedQuestions[index]
    }
    func updateData(withObjectId objectId: String, tableView: UITableView!) {
        nameTest.fetchDataFromAPI(objectId: objectId, token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) {  [weak self] questions in

            DispatchQueue.main.async {
                if let fetchedQuestions = questions {
                    Manager.fetchedQuestions = fetchedQuestions
                    tableView.reloadData()
                } else {
                    if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: Manager.name_test) {
                        Manager.fetchedQuestions = questionsArray
                    }
                    tableView.reloadData()
                }
                self?.activityIndicator?.stopAnimating()
                self?.activityIndicator?.removeFromSuperview()
            }
        }
    }
    func startTest() {
        Manager.questions = Manager.fetchedQuestions
    }
}
