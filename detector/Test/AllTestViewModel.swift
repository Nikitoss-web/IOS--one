import Foundation
import UIKit

protocol AnswersDelegate:  AnyObject {
    func SavingResponses(answer: [String])
    func ResultAnswer(answers: [String])
}
protocol AnswerResultsDelegates: AnyObject{
    func ResultAnswers(answers: [String])
}
final class AllTestViewModel{
    var bluetoothFinished: ((Bool) -> Void)?
    var fetchedQuestions: [String] = []
    var answers: [String] = []
    var answerResults: [String] = []
    weak var delegate: AllTestVCDelegate?
    let bluetoothManager = BluetoothManagerProvider.shared.bluetoothManager
    private var calculat = CalculatingResult()

    func bluetoothStart(){
        bluetoothManager.receivedDataArray.removeAll()
        let message = "start"
        if let data = message.data(using: .utf8) {
            bluetoothManager.sendDataToPeripheral(data: data)
        }
    }
    func bluetoothStop() -> Bool{
        let message = "stop"
        if let data = message.data(using: .utf8) {
            bluetoothManager.sendDataToPeripheral(data: data)        }
        return calculat.responseResult(array: bluetoothManager.receivedDataArray, maxECG: TimersView.maxECG)
    }
    func recordAnswer(answer: String) {
        answers.append(answer)
    }
    func recordAnswerResult( bool: Bool){
        let result = bool ? "Truth" : "Lie"
        answerResults.append(result)
    }
    func delegateAllTestViewModel(vc: TestUserViewModel){
        vc.fetchedQuestions = fetchedQuestions
        vc.answer = answers
        vc.answerResults = answerResults
        vc.delegate = self
    }
    func currentQuestionIndex(textLable: UILabel!) -> Int{
        delegate?.settingsVCDidUpdateQuestion(fetchedQuestions: fetchedQuestions)
        guard let currentQuestionIndex = fetchedQuestions.firstIndex(where: { $0 == textLable.text }) else { return 0 }
        
        return currentQuestionIndex + 1
    }
}
extension AllTestViewModel: AllTestVCDelegate{
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
