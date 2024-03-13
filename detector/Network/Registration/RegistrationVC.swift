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
        if (nameText.text?.isEmpty == false), (emailText.text?.isEmpty == false), (passwordText.text?.isEmpty == false) {
            registrain.connection(password: passwordText.text!, email: emailText.text!, name: nameText.text!, setting: registrain.userRegister())
            navigationController?.popViewController(animated: true)
            dismiss(animated: true)
            AlertManager.showAlert(viewController: self)
        } else {
            AlertManager.notShowAlert(viewController: self)
        }
    }
    @IBAction private func cansel(){
        navigationController?.popViewController(animated: true)

    }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }


}
