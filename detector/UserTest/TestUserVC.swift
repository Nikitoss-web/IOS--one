import UIKit

class TestUserVC: UIViewController {
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var lastnameLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var saveResulButton: UIButton!
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var lastnameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    var viewModel = TestUserViewModel(resultsRecording: RecordingResultsAPI())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizable()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func saveResultsTest() {
        viewModel.saveTestResult(name: nameField.text ?? "", lastname: lastnameField.text ?? "", age: ageField.text ?? "")
        let storyboard = UIStoryboard(name: Screen.mainStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestVC.self)) as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
      }
    
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }
    private func localizable() {
        nameLable.text = NSLocalizedString("name", comment: "")
        lastnameLable.text = NSLocalizedString("lastname", comment: "")
        ageLable.text = NSLocalizedString("age", comment: "")
        saveResulButton.setTitle(NSLocalizedString("save_result", comment: ""), for: .normal)
    }
   }
