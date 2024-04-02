import UIKit
class ViewControllerModel {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func validationUserToken(){
        var dataToken = KeychainManager.getPassword(for: "userToken")
        var userToken =  String(decoding: dataToken ?? Data(), as: UTF8.self)
         if (!userToken.isEmpty){
             let mainStorybord = UIStoryboard(name: Screen.MainStorybord.rawValue, bundle: nil)
             let secondVC1 = mainStorybord.instantiateViewController(withIdentifier: String(describing: TestVC.self))
             navigationController?.pushViewController(secondVC1, animated: true)
         }
    }
}
