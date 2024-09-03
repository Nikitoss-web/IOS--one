import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var loginButton: UILabel!
    @IBOutlet weak var passwordButton: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var canselButton: UIButton!
    @IBOutlet weak var passwordAU: UITextField!
    @IBOutlet weak var loginText: UITextField!
    @IBOutlet weak var restorationButton: UIButton!
    let viewModel = LoginViewModel(networkAuthorization: NetworkLoginAPI())
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  localizable()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func closeButton() {
        viewModel.showNextScreen = { [weak self] message in
                self?.next(message: message)
            }
        viewModel.connect(password: passwordAU.text, login: loginText.text )
        }
    
    @IBAction private func cancel() {
        navigationController?.popViewController(animated: true)
    }
    @IBAction private func restoration(){
        let mainStoryboard = UIStoryboard(name: Screen.main.rawValue, bundle: nil)
        let registrationVC = mainStoryboard.instantiateViewController(withIdentifier: String(describing: RegistrationVC.self))
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }
    
    private func next(message: String){
        AlertManager.showAlert(viewController: self, message: message, completion: {
            let storyboard = UIStoryboard(name: Screen.mainStoryboard.rawValue, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestVC.self)) as? TestVC {
                self.navigationController?.pushViewController(vc, animated: true)
            }})
    }
    
//    private func localizable() {
//        loginButton.text = NSLocalizedString("login", comment: "")
//        passwordButton.text = NSLocalizedString("password", comment: "")
//        saveButton.setTitle(NSLocalizedString("save", comment: ""), for: .normal)
//        canselButton.setTitle(NSLocalizedString("cansel", comment: ""), for: .normal)
//    }
}
