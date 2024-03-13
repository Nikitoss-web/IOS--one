////
////  TestVC.swift
////  detector
////
////  Created by НИКИТА ПЕСНЯК on 2.02.24.
////
import UIKit
import CoreBluetooth

class TestVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CBCentralManagerDelegate{

    
    @IBOutlet weak var tableView: UITableView!
    var tests: [Test] = []
    var result: [ViewResults] = []
      var activityIndicator: UIActivityIndicatorView!
    var simpleBluetoothIO: BluetoothManager!
    private let question = OnlineQuestion()
      override func viewDidLoad() {
          super.viewDidLoad()
          navigationItem.hidesBackButton = true
          setupUI()
          fetchData()
          simpleBluetoothIO = BluetoothManager()
          simpleBluetoothIO.centralManager.delegate = self
       
      }
      
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            print("Bluetooth включен. Сканирование устройств...")
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth не включен.")
        }
    }
      
        private func setupUI() {
            activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.center = view.center
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            tableView.dataSource = self
            tableView.delegate = self
        }
    @IBAction private func button(){
        
        let message = "start"
        if let data = message.data(using: .utf8) {
            simpleBluetoothIO.sendDataToPeripheral(data: data)
        }
       
        
        
    }
    @IBAction private func buttons(){
        
        let message = "stop"
        if let data = message.data(using: .utf8) {
            simpleBluetoothIO.sendDataToPeripheral(data: data)
        }}
    @IBAction private func resultsButton(){
        let storyboard = UIStoryboard(name: "ResultsStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ResultsVC") as? ResultsVC {
            navigationController?.pushViewController(vc, animated: true)
        }}
    @IBAction private func exitButton(){
        navigationController?.popViewController(animated: true)
        }
        
    private func fetchData() {
        question.fetchDataFromBackendless(token: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self)) { [weak self] test in
            DispatchQueue.main.async {
                if let tests = test {
                    self?.tests = tests
                    self?.tableView.reloadData()

                } else {
                     let questions = CoreDataService.shared.fetchQuestions()
                    self?.tests = questions.map { Test(name_test: $0, test_number: nil, objectId: "") }
                    self?.tableView.reloadData()
                }
                
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.removeFromSuperview()
            }
        }
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tests.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier", for: indexPath)
            let name = tests[indexPath.row].name_test
            cell.textLabel?.text = name
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let objectId = tests[indexPath.row].objectId
            let name_test = tests[indexPath.row].name_test
            let storyboard = UIStoryboard(name: "MainStorybord", bundle: nil)
            

            if let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVС") as? SettingsVС {
                vc.updateData(withObjectId: objectId)
                vc.name_test = name_test
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
