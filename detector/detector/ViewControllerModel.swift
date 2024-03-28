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
             let mainStorybord = UIStoryboard(name: "MainStorybord", bundle: nil)
             let secondVC1 = mainStorybord.instantiateViewController(identifier: "TestVC")
             navigationController?.pushViewController(secondVC1, animated: true)
         }
    }
}
