import UIKit

class ReportVC: UIViewController {
    @IBOutlet private weak var nameLable: UILabel!
    @IBOutlet private weak var lastnameLable: UILabel!
    @IBOutlet private weak var ageLable: UILabel!
    @IBOutlet private weak var questionField: UITextView!
    var viewModel = ReportViewModel(report: Report())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        result()
    }
    
    private func result() {
           if let reportOutput = viewModel.setupReport() {
               DispatchQueue.main.async {
                   self.nameLable.text = reportOutput.name
                   self.lastnameLable.text = reportOutput.lastName
                   self.ageLable.text = reportOutput.age
                   self.questionField.text = reportOutput.text
               }
           }
       }
}
