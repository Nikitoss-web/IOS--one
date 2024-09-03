import UIKit
class ViewControllerViewModel {
    
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func validationUserToken() {
        if let userToken =  KeychainManager.getPassword(for: AccountEnum.userToken.rawValue){
            if (!userToken.isEmpty){
                let mainStoryboard = UIStoryboard(name: Screen.mainStoryboard.rawValue, bundle: nil)
                let secondVC1 = mainStoryboard.instantiateViewController(withIdentifier: String(describing: TestVC.self))
                navigationController?.pushViewController(secondVC1, animated: true)
            }
        }
    }
}
