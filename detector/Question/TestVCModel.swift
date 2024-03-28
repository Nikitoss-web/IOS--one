import Foundation
import UIKit
class TestVCModel{
    var tests: [Test] = []
    var result: [ViewResults] = []
    private let question = OnlineQuestion()
    var simpleBluetoothIO =  BluetoothManager()
    private weak var navigationController: UINavigationController?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var testsCount: Int {
        return tests.count
    }
    func  testName(at index: Int) -> String {
        return tests[index].name_test
    }
    func  objectId(at index: Int) -> String {
        return tests[index].objectId
    }
    func fetchData(tableView: UITableView!) {
        question.fetchDataFromBackendless(token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) { [weak self] test in
            DispatchQueue.main.async {
                if let tests = test {
                    self?.tests = tests
                    tableView.reloadData()
                    
                } else {
                    let questions = CoreDataService.shared.fetchQuestions()
                    self?.tests = questions.map { Test(name_test: $0, test_number: nil, objectId: "") }
                    tableView.reloadData()
                }
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
            }
        }
    }
    func transferSettingsVС(at index: Int, viewController: SettingsVС) {
        SettingsViewModel.objectId = objectId(at: index)
        SettingsViewModel.name_test = testName(at: index)
    }
    }

