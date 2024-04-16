import UIKit
final class ViewController: UIViewController {
    @IBOutlet weak var registrationsButton: UIButton!
    @IBOutlet weak var authorizationsButton: UIButton!
    var viewModel: ViewControllerViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizable()
        viewModel = ViewControllerViewModel(navigationController: navigationController!)
            viewModel.validationUserToken()
    }
    
    @IBAction private func registrationButton() {
        let mainStoryboard = UIStoryboard(name: Screen.main.rawValue, bundle: nil)
        let registrationVC = mainStoryboard.instantiateViewController(withIdentifier: String(describing: RegistrationVC.self))
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    @IBAction private func authorizationButton() {
        let mainStoryboard = UIStoryboard(name: Screen.main.rawValue, bundle: nil)
        let secondVC = mainStoryboard.instantiateViewController(withIdentifier: String(describing: LoginVC.self))
        navigationController?.pushViewController(secondVC, animated: true)
    }
    private func localizable() {
        registrationsButton.setTitle(NSLocalizedString("registration", comment: ""), for: .normal)
        authorizationsButton.setTitle(NSLocalizedString("authorization", comment: ""), for: .normal)
    }
}

    
     


