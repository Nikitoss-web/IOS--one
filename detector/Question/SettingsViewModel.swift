import UIKit
protocol AllTestVCDelegate: AnyObject {
    func settingsVCDidUpdateQuestion(fetchedQuestions: [String])
}
class SettingsViewModel {
    weak var delegate: SettingsVCDelegate?
    var objectId: String?
    var name_Test: String?
    var fetchedQuestions: [String] = []
    var questions: [String] = []
    private let nameTest = OnlineNameTestAPI()
    var tests: [Test] = []{
        didSet{
            testLoaded?()
        }
    }
    var testLoaded: (() -> Void)?
    var fetchedQuestion: [String] {
        return  fetchedQuestions
    }
    var fetchedQuestionsCount: Int {
        
        return  fetchedQuestions.count
    }
    func question(at index: Int) -> String {
        return fetchedQuestions[index]
    }
 
    func updateData() {
        delegate?.settingsVCDidUpdateData(objectId: objectId, nameTest: name_Test)
        
        nameTest.fetchDataFromAPI(objectId: objectId ?? "" , token: KeychainManager.getPassword(for: AccountEnum.userToken.rawValue) ?? "") {  [weak self] questions in

            DispatchQueue.main.async {
                if let fetchedQuestions = questions {
                    self?.fetchedQuestions = fetchedQuestions
                    self?.testLoaded?()
                } else {
                    if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: self?.name_Test ?? "") {
                        self?.fetchedQuestions = questionsArray
                        self?.testLoaded?()
                    }
                }
            }
        }
    }
    func startTest(fetchedQuestion: [String],vc: AllTestViewModel) {
        vc.fetchedQuestions = fetchedQuestion
        vc.delegate = self
    }
}
extension SettingsViewModel: AllTestVCDelegate{
    func settingsVCDidUpdateQuestion(fetchedQuestions: [String]) {
        self.fetchedQuestions = fetchedQuestions
    }
}
