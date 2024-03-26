
//
//  SecondVC.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 1.02.24.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var passwordAU: UITextField!
    @IBOutlet weak var loginText: UITextField!
    private let networkAut = NetworkСonnectionAU()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    @IBAction private func closeButton(){
        if (passwordAU.text?.isEmpty == false), (loginText.text?.isEmpty == false) {
            networkAut.connectionAUT(password: passwordAU.text!, login: loginText.text! , setting: networkAut.logins()){ message, error in
                if let message = message {
                    DispatchQueue.main.async {
                        let mainStorybord = UIStoryboard(name: "MainStorybord", bundle: nil)
                        let registrationVC = mainStorybord.instantiateViewController(identifier: "TestVC")
                        let alert = AlertManager.showAlert(viewController: self, message: message)
                        self.navigationController?.pushViewController(registrationVC, animated: true)}
                    
                }
                
            }} else {
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
