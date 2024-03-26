//import Foundation
//import UIKit
//
//class TestViewModel {
//    private var tests: [Test] = []
//    private let question = OnlineQuestion()
//    
//    var testsCount: Int {
//        return tests.count
//    }
//    
//    func testName(at index: Int) -> String {
//        return tests[index].name_test
//    }
//    
//    func fetchData(completion: @escaping () -> Void) {
//        question.fetchDataFromBackendless(token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) { [weak self] test in
//            if let tests = test {
//                self?.tests = tests
//            } else {
//                let questions = CoreDataService.shared.fetchQuestions()
//                self?.tests = questions.map { Test(name_test: $0, test_number: nil, objectId: "") }
//            }
//            completion()
//        }
//    }
//    
//    func showResults() {
//        let storyboard = UIStoryboard(name: "ResultsStorybord", bundle: nil)
//        if storyboard.instantiateViewController(withIdentifier: "ResultsVC") is ResultsVC {
//        }
//    }
//    
//    func didSelectTest(at index: Int) {
//        let objectId = tests[index].objectId
//        let name_test = tests[index].name_test
//        let storyboard = UIStoryboard(name: "MainStorybord", bundle: nil)
//        if let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVС") as? SettingsVС {
//            vc.updateData(withObjectId: objectId)
//            vc.name_test = name_test
//        }
//    }
//}
