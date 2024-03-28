//
//  RegistrationVC.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 2.02.24.
//

import UIKit

class RegistrationVC: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    private let registrain = NetworkСonnection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    @IBAction private func saveButton(){
            registrain.connection(password: passwordText.text!, email: emailText.text!, name: nameText.text!, setting: registrain.userRegister()) { message, error in
                 if let message = message {
                    DispatchQueue.main.async {
                       AlertManager.showAlert(viewController: self, message: message, completion: {
                           let mainStorybord = UIStoryboard(name: "MainStorybord", bundle: nil)
                           let registrationVC = mainStorybord.instantiateViewController(identifier: "TestVC")
                           self.navigationController?.pushViewController(registrationVC, animated: true)
                        })
                               }
                           }
                       }}
    
    @IBAction private func cansel(){
        navigationController?.popViewController(animated: true)

    }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }


}
