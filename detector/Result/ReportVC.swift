import UIKit

class ReportVC: UIViewController {
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var lastnameLable: UILabel!
    @IBOutlet private weak var ageLable: UILabel!
    @IBOutlet private weak var questionField: UITextView!
    weak var delegate: AllTestVCDelegate?
    var fetchedQuestions: [String] = []
    var selectedResult: ViewResults?
    weak var delegates: SelectedResultDelegatets?
    private let viewModel = ReportViewModel()
       override func viewDidLoad() {
           super.viewDidLoad()
           delegates?.ResultSelected(selectedResult: selectedResult)
           viewModel.setupReport(selectedResult: selectedResult, nameLable: nameLable, lastnameLable: lastnameLable, ageLable: ageLable, questionField: questionField, question: &fetchedQuestions)
       }
}
