import Foundation
import UIKit
protocol SettingsVCDelegate: AnyObject {
    
    func settingsVCDidUpdateData(objectId: String?, nameTest: String?)
}

class TestViewModel {
    var objectId: String?
    var name_test: String = ""
    var testLoaded: (() -> Void)?
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var tests: [Test] = []
    private let question: OnlineQuestion
     
    init(question: OnlineQuestion) {
         self.question = question
     }
    
    var test: [Test] = [] {
        didSet{
            testLoaded?()
        }
    }

    
    var testsCount: Int {
        return tests.count
    }
    
    func  testName(at index: Int) -> String {
        return tests[index].name_test
    }
    
    func objectId(at index: Int) -> String {
        return tests[index].objectId
    }
    
    func fetchData() {
        question.fetchDataFromBackendless(token: KeychainManager.getPassword(for: AccountEnum.userToken.rawValue) ?? "") { [weak self] (test: Result<[Test]?, ErrorAPI> ) in
            DispatchQueue.main.async {
                switch test {
                case .success(let test):
                    if let testss = test {
                        self?.tests = testss
                        self?.testLoaded?()
                    } else {
                        let questions = CoreDataService.shared.fetchQuestions()
                        self?.tests = questions.map { Test(name_test: $0, test_number: nil, objectId: "")
                        }
                        self?.testLoaded?()
                    }
                case .failure(let error):
                    print("Ошибка при получении результатов: \(error)")
                }
            }
        }}
    
    func settingsVCDelegate(objectId: String,testName: String,  vcc: SettingsViewModel) {
        vcc.objectId = objectId
        vcc.name_Test = testName
        vcc.delegate = self
    }
}

extension TestViewModel: SettingsVCDelegate {
    func settingsVCDidUpdateData(objectId: String?, nameTest: String?) {
        self.objectId = objectId
        self.name_test = nameTest ?? ""
    }
}
