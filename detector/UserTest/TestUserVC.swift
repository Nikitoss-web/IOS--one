//
//  TestUserVC.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 8.02.24.
//

import UIKit
struct TestResult {
    var name: String
    var lastname: String
    var age: String
    var answers: String
}
class TestUserVC: UIViewController {
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var lastnameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    
    var questions: [String] = []
    var answers: [String] = []
    private let resultsRecording = RecordingResults()
    let simpleBluetoothIO = BluetoothManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction private func saveResutsTest(){
        
        let combinedArray = Array(zip(questions, answers)).flatMap { [$0, $1] }
          let combinedString = combinedArray.joined(separator: " ")
        let result = TestResult(name: nameField.text ?? "", lastname: lastnameField.text ?? "", age: ageField.text ?? "", answers: combinedString)
        let recording = Recording(name: result.name, lastname: result.lastname, age: result.age, answers: result.answers, ownerId: String(decoding: KeychainManager.getPassword(for: "userId") ?? Data(), as: UTF8.self))
        resultsRecording.RecordingResult(recording: recording, userId: String(decoding: KeychainManager.getPassword(for: "userId") ?? Data(), as: UTF8.self), token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self))
        let storyboard = UIStoryboard(name: "MainStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TestVC") as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
       }
    @objc private func dismissKeyboard() {
           view.endEditing(true)
       }
   }
