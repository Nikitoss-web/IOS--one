import UIKit

class TestUserVC: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var lastnameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    var viewModel = TestUserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @IBAction private func saveResultsTest(){
        viewModel.saveTestResult(name: nameField.text ?? "", lastname: lastnameField.text ?? "", age: ageField.text ?? "")
        let storyboard = UIStoryboard(name: Screen.mainStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestVC.self)) as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
      }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }
   }
