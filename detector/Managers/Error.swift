//
//  Error.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 2.02.24.
//

import UIKit


class AlertManager {
    static func notShowAlert(viewController: UIViewController?) {
        let alert = UIAlertController(title: "Data not entered", message: "Enter data", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
         viewController?.present(alert, animated: true)
    }

    static func showAlert(viewController: UIViewController?, message: String, completion: @escaping() -> Void) {
        let alert = UIAlertController(title: !message.isEmpty ? message : "You have registered", message: nil, preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "OK", style: .default) { _ in
            if message.isEmpty {
                completion()
            }
        }
        
        alert.addAction(okButton)
        viewController?.present(alert, animated: true)
    }
}
