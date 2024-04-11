import UIKit
class ReportViewModel{
    var answers: [String] = []
    var answerResults: [String] = []
    private let report = Report()
    func setupReport(selectedResult: ViewResults?, nameLable: UILabel, lastnameLable: UILabel, ageLable: UILabel, questionField: UITextView, question: inout [String]) {
        report.outputResults(selectedResult: selectedResult, nameLable: nameLable, lastnameLable: lastnameLable, ageLable: ageLable, questions: &question, answers: &answers, answerResults: &answerResults, questionField: questionField)
       }
}
