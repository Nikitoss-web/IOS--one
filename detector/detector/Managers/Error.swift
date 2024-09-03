import UIKit

class AlertManager {
    static func notShowAlert(viewController: UIViewController?) {
        let alert = UIAlertController(title: NSLocalizedString("data_entered", comment: ""), message: NSLocalizedString("enter_data", comment: ""), preferredStyle: .alert)

        let okButton = UIAlertAction(title:  NSLocalizedString("ok", comment: ""), style: .default)
        alert.addAction(okButton)
         viewController?.present(alert, animated: true)
    }
    
    static func showAlert(viewController: UIViewController?, message: String, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: !message.isEmpty ? message : NSLocalizedString("you_registration", comment: ""), message: nil, preferredStyle: .alert)

        
        let okButton = UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            if message.isEmpty {
                completion()
            }
        }
        alert.addAction(okButton)
        viewController?.present(alert, animated: true)
    }
}
