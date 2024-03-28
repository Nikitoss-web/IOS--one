import UIKit
final class ViewController: UIViewController{
    var viewModel: ViewControllerModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewControllerModel(navigationController: navigationController!)
            viewModel.validationUserToken()
    }
    @IBAction private func regButton(){
       
        let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
        let registrationVC = mainStorybord.instantiateViewController(identifier: "RegistrationVC")
        navigationController?.pushViewController(registrationVC, animated: true)

    }
    @IBAction private func avtButton(){
        let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStorybord.instantiateViewController(identifier: "SecondVC")
        navigationController?.pushViewController(secondVC, animated: true
        )
    }
    }
    
    
     


