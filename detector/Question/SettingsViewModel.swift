import UIKit
protocol AllTestVCDelegate: AnyObject {
    
    func settingsVCDidUpdateQuestion(fetchedQuestions: [String])
}
class SettingsViewModel {
    
    var objectId: String?
    var name_Test: String?
    var testLoaded: (() -> Void)?
    weak var delegate: SettingsVCDelegate?
    private var fetchedQuestions: [String] = []
    private var questions: [String] = []
    private let nameTest: OnlineNameTest
    
    init (nameTest: OnlineNameTest) {
        self.nameTest = nameTest
    }
    var tests: [Test] = []{
        didSet{
            testLoaded?()
        }
    }
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
        
        nameTest.fetchDataFromAPI(objectId: objectId ?? "" , token: KeychainManager.getPassword(for: AccountEnum.userToken.rawValue) ?? "") {  [weak self] (questions: Result<[String]?, ErrorAPI>) in
            
            DispatchQueue.main.async {
                switch questions {
                case .success(let questions):
                    if let fetchedQuestions = questions {
                        self?.fetchedQuestions = fetchedQuestions
                        self?.testLoaded?()
                    } else {
                        if let questionsArray = CoreDataService.shared.fetchQuestionsFromCoreData(forownerId: self?.name_Test ?? "") {
                            self?.fetchedQuestions = questionsArray
                            self?.testLoaded?()
                        }
                    }
                case .failure(let error):
                    print("Ошибка при получении результатов: \(error)")
                }
            }
        }
    }
    
    func startTest(fetchedQuestion: [String],vc: AllTestViewModel) {
        vc.fetchedQuestions = fetchedQuestion
        vc.delegate = self
    }
}

extension SettingsViewModel: AllTestVCDelegate {
    func settingsVCDidUpdateQuestion(fetchedQuestions: [String]) {
        self.fetchedQuestions = fetchedQuestions
    }
}
