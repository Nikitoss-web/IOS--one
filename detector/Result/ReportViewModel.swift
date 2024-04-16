import UIKit

class ReportViewModel {
    var selectedResult: ViewResults?
    weak var delegates: SelectedResultDelegatets?
    private var answers: [String] = []
    private var answerResults: [String] = []
    private var fetchedQuestions: [String] = []
    private let report: Reports

    init(report: Reports) {
        self.report = report
    }

    func setupReport() -> ReportOutput? {
        delegates?.ResultSelected(selectedResult: selectedResult)
        if let resultsTuple = report.outputResults(selectedResult: selectedResult) {
            let text = resultsTuple.questions.joined(separator: "\n")
            
            let output = ReportOutput(
                name: resultsTuple.name,
                lastName: resultsTuple.lastname,
                age: resultsTuple.age,
                text: resultsTuple.textViewText
            )

            return output
        }
        return nil
    }
}
