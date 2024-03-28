import UIKit
class ReportVCModel{
    private let report = Report()
    static var selectedResult: ViewResults?
       var questions: [String] = []
       var answers: [String] = []
       func setupReport(selectedResult: ViewResults?, nameLable: UILabel, lastnameLable: UILabel, ageLable: UILabel, questionField: UITextView) {
           report.outputResults(selectedResult: selectedResult, nameLable: nameLable, lastnameLable: lastnameLable, ageLable: ageLable, questions: &questions, answers: &answers, questionField: questionField)
       }
}
