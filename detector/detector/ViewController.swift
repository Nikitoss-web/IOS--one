import UIKit
final class ViewController: UIViewController{
    var viewModel: ViewControllerModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewControllerModel(navigationController: navigationController!)
            viewModel.validationUserToken()
    }
    @IBAction private func regButton(){
        let mainStorybord = UIStoryboard(name: Screen.Main.rawValue, bundle: nil)
        let registrationVC = mainStorybord.instantiateViewController(withIdentifier: String(describing: RegistrationVC.self))
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    @IBAction private func avtButton(){
        let mainStorybord = UIStoryboard(name: Screen.Main.rawValue, bundle: nil)
        let secondVC = mainStorybord.instantiateViewController(withIdentifier: String(describing: LoginVC.self))
        navigationController?.pushViewController(secondVC, animated: true)
    }
    }

    
     


