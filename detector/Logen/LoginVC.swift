import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var passwordAU: UITextField!
    @IBOutlet weak var loginText: UITextField!
    let viewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    @IBAction private func closeButton(){
        viewModel.nextScreen = { [weak self] message in
                self?.next(message: message)
            }
        viewModel.connect(password: passwordAU.text, login: loginText.text )
        }
    @IBAction private func cancel(){
        navigationController?.popViewController(animated: true)
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
}
