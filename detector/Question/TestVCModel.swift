import Foundation
import UIKit

class TestVCModel{
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private let question = OnlineQuestion()
    private weak var navigationController: UINavigationController?
    var testsCount: Int {
        return Manager.tests.count
    }
    func  testName(at index: Int) -> String {
        return Manager.tests[index].name_test
    }
    func  objectId(at index: Int) -> String {
        return Manager.tests[index].objectId
    }
    func fetchData(tableView: UITableView!) {
        question.fetchDataFromBackendless(token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) { [weak self] test in
            DispatchQueue.main.async {
                if let tests = test {
                    Manager.tests = tests
                    tableView.reloadData()
                    
                } else {
                    let questions = CoreDataService.shared.fetchQuestions()
                    Manager.tests = questions.map { Test(name_test: $0, test_number: nil, objectId: "") }
                    tableView.reloadData()
                }
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
            }
        }
    }
    func transferSettingsVС(at index: Int, viewController: SettingsVС) {
        Manager.objectId = objectId(at: index)
        Manager.name_test = testName(at: index)
    }
    }

