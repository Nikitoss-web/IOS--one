import UIKit

class TestUserVC: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var lastnameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    private var viewModel = TestUserVCViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @IBAction private func saveResutsTest(){
        viewModel.saveTestResult(name: nameField.text ?? "", lastname: lastnameField.text ?? "", age: ageField.text ?? "", questions: Manager.questions, answers: Manager.answers, responseResults: Manager.answerResults)
        let storyboard = UIStoryboard(name: Screen.MainStorybord.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestVC.self)) as? TestVC {
            Manager.tests  = []
            Manager.result  = []
            Manager.name_test = ""
            Manager.fetchedQuestions = []
            Manager.questions = []
            Manager.answers = []
            Manager.responseResult  = []
            navigationController?.pushViewController(vc, animated: true)
        }
      }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }
   }
