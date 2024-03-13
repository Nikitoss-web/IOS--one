//
//  ViewController.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 1.02.24.
//

import UIKit
final class ViewController: UIViewController{
    var names: [String] = []
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
         var dataToken = KeychainManager.getPassword(for: "userToken")
       var userToken =  String(decoding: dataToken ?? Data(), as: UTF8.self)

        if (!userToken.isEmpty){
            sdutton()
        }
        if let tests = CoreDataService.shared.fetchTests() {
            for test in tests {
                print("Test Name: \(test.name_test), Test Number: \(test.test_number ?? "N/A"), Object ID: \(test.objectId)")
            }
        } else {
            print("Не удалось получить данные из CoreData")
        }
    }

    
    
    
    @IBAction private func regButton(){
       
        let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
        let registrationVC = mainStorybord.instantiateViewController(identifier: "RegistrationVC")
        navigationController?.pushViewController(registrationVC, animated: true)

    }
    @IBAction private func avtButton(){
        let mainStorybord = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = mainStorybord.instantiateViewController(identifier: "SecondVC")
//       present(secondVC, animated: true)
        navigationController?.pushViewController(secondVC, animated: true
        )
    }
    @IBAction private func sdutton(){
        let mainStorybord = UIStoryboard(name: "MainStorybord", bundle: nil)
        let secondVC1 = mainStorybord.instantiateViewController(identifier: "TestVC")
        navigationController?.pushViewController(secondVC1, animated: true
        )
    }
    
    
     
}

