
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
    private let networkAut = NetworkСonnectionAUT()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    @IBAction private func closeButton(){
        if (passwordAU.text?.isEmpty == false), (loginText.text?.isEmpty == false) {
            networkAut.connectionAUT(password: passwordAU.text!, login: loginText.text! , setting: networkAut.logins())
            let mainStorybord = UIStoryboard(name: "MainStorybord", bundle: nil)
            let registrationVC = mainStorybord.instantiateViewController(identifier: "TestVC")
            navigationController?.pushViewController(registrationVC, animated: true)

            
        } else {
            AlertManager.notShowAlert(viewController: self)
        }
    }
       
    
    @IBAction private func cansel(){
//        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }

}
