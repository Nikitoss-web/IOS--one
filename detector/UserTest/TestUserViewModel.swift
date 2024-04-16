import Foundation

class TestUserViewModel {
    var fetchedQuestions: [String] = []
    var answerResults: [String] = []
    var answer: [String] = []
    weak var delegate: AllTestVCDelegate?
    weak var delegats: AnswersDelegate?
    private let resultsRecording: RecordingResults
    
    init(resultsRecording: RecordingResults){
         self.resultsRecording = resultsRecording
     }
    
    func saveTestResult(name: String, lastname: String, age: String) {
        delegate?.settingsVCDidUpdateQuestion(fetchedQuestions: fetchedQuestions)
        delegats?.SavingResponses(answer: answer)
        delegats?.ResultAnswer(answers: answerResults)
        var combinedArray = [String]()
        for index in 0..<fetchedQuestions.count {
            combinedArray.append(fetchedQuestions[index])
            combinedArray.append(answer[index])
            combinedArray.append(answerResults[index])
        }
        let combinedString = combinedArray.joined(separator: " ")
        let result = TestResult(name: name, lastname: lastname, age: age, answers: combinedString)
        let recording = Recording(name: result.name, lastname: result.lastname, age: result.age, answers: result.answers, ownerId:  KeychainManager.getPassword(for: AccountEnum.userId.rawValue) ?? "")
        resultsRecording.recordingResult(recording: recording, userId: KeychainManager.getPassword(for: AccountEnum.userId.rawValue) ?? "", token:  KeychainManager.getPassword(for: AccountEnum.userToken.rawValue) ?? "")
    }
}
