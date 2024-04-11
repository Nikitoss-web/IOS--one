import UIKit

class RegistrationVC: UIViewController {
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    let viewModel = RegistrationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func saveButton(){
        
        viewModel.nextScreen = { [weak self] message in
            self?.next(message: message)
        }
        viewModel.connect(name: nameText.text, email: emailText.text, password: passwordText.text)
    }
    @IBAction private func cancel(){
        navigationController?.popViewController(animated: true)
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
}
