import UIKit
struct TestResult {
    var name: String
    var lastname: String
    var age: String
    var answers: String
}
class TestUserVC: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var lastnameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    private var viewModel = TestUserVCViewModel()
    var questions: [String] = []
    var answers: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func saveResutsTest(){
        viewModel.saveTestResult(name: nameField.text ?? "", lastname: lastnameField.text ?? "", age: ageField.text ?? "", questions: questions, answers: answers)
                  
          let storyboard = UIStoryboard(name: "MainStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TestVC") as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
      }
    
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }
   }
