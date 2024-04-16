import Foundation
import UIKit

protocol AnswersDelegate:  AnyObject {
    func SavingResponses(answer: [String])
    func ResultAnswer(answers: [String])
}
protocol AnswerResultsDelegates: AnyObject {
    
    func ResultAnswers(answers: [String])
}

final class AllTestViewModel {
    var fetchedQuestions: [String] = []
    weak var delegate: AllTestVCDelegate?
    private var bluetoothFinished: ((Bool) -> Void)?
    private var answers: [String] = []
    private var answerResults: [String] = []
    private let bluetoothManager = BluetoothManagerProvider.shared.bluetoothManager
    private var calculat: Calculating
    
    init (calculat: Calculating) {
        self.calculat = calculat
    }

    func bluetoothStart() {
        bluetoothManager.receivedDataArray.removeAll()
        let message = TestResultEnum.messageStart.rawValue
        if let data = message.data(using: .utf8) {
            bluetoothManager.sendDataToPeripheral(data: data)
        }
    }
    
    func bluetoothStop() -> Bool {
        let message = TestResultEnum.messageStop.rawValue
        if let data = message.data(using: .utf8) {
            bluetoothManager.sendDataToPeripheral(data: data)        }
        return calculat.responseResult(array: bluetoothManager.receivedDataArray, maxECG: TimersView.maxECG)
    }
    
    func recordAnswer(answer: String) {
        answers.append(answer)
    }
    func recordAnswerResult( bool: Bool) {
        let result = bool ? TestResultEnum.resultTruth.rawValue : TestResultEnum.resultLie.rawValue
        answerResults.append(result)
    }
    
    func delegateAllTestViewModel(vc: TestUserViewModel) {
        vc.fetchedQuestions = fetchedQuestions
        vc.answer = answers
        vc.answerResults = answerResults
        vc.delegate = self
    }
    
    func currentQuestionIndex(textLabel: String) -> Int {
        delegate?.settingsVCDidUpdateQuestion(fetchedQuestions: fetchedQuestions)
        guard let currentQuestionIndex = fetchedQuestions.firstIndex(where: { $0 == textLabel }) else { return 0 }
        
        return currentQuestionIndex + 1
    }
}

extension AllTestViewModel: AllTestVCDelegate {
    func settingsVCDidUpdateQuestion(fetchedQuestions: [String]) {
        self.fetchedQuestions = fetchedQuestions
    }
    
}

extension AllTestViewModel: AnswersDelegate {
    func SavingResponses(answer: [String]) {
        self.answers = answer
    }
    func ResultAnswer(answers: [String]) {
           self.answerResults = answers
       }
}
