import UIKit

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var savesButton: UIButton!
    @IBOutlet weak var canselButton: UIButton!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    let viewModel = RegistrationViewModel(registrain: NetworkСonnectionAPI())
    
    override func viewDidLoad() {
     //   localizable()
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func saveButton() {
        viewModel.showNextScreen = { [weak self] message in
            self?.next(message: message)
        }
        viewModel.connect(name: nameText.text, email: emailText.text, password: passwordText.text)
    }
    
    @IBAction private func Login() {
        let mainStoryboard = UIStoryboard(name: Screen.main.rawValue, bundle: nil)
        let registrationVC = mainStoryboard.instantiateViewController(withIdentifier: String(describing: LoginVC.self))
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func next(message: String){
        AlertManager.showAlert(viewController: self, message: message, completion: {
            let storyboard = UIStoryboard(name: Screen.main.rawValue, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }})
    }
    
//    private func localizable(){
//        nameLable.text = NSLocalizedString("name", comment: "")
//        emailLable.text = NSLocalizedString("email", comment: "")
//        passwordLable.text = NSLocalizedString("password", comment: "")
//        savesButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
//        canselButton.setTitle(NSLocalizedString("cansel", comment: ""), for: .normal)
//    }
}
