import UIKit
class ReportVCModel{
    private let report = Report()
       func setupReport(selectedResult: ViewResults?, nameLable: UILabel, lastnameLable: UILabel, ageLable: UILabel, questionField: UITextView) {
           report.outputResults(selectedResult: selectedResult, nameLable: nameLable, lastnameLable: lastnameLable, ageLable: ageLable, questions: &Manager.questions, answers: &Manager.answers, answerResults: &Manager.answerResults, questionField: questionField)
       }
}
