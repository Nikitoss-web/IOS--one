//
//  ResultsVC.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 13.02.24.
//

import UIKit

class ResultsVC: UIViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    private let resultsView = viewResult()
    var result: [ViewResults] = []
    let simpleBluetoothIO = BluetoothManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.tableView.reloadData()
        resultsData(userToken: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self))
        tableView.delegate = self
    }
    
    func resultsData(userToken: String){
        resultsView.viewResul(token: userToken, userId: String(decoding: KeychainManager.getPassword(for: "userId") ?? Data(), as: UTF8.self)) { [weak self] results in
            DispatchQueue.main.async {
                if let result = results {
                    self?.result = result
                    self?.tableView.reloadData()
                } else {
                    print("Ошибка при получении результатов")
                }
            }}}
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier3", for: indexPath) as! ResultTableViewCell
        
        let results = result[indexPath.row]
        cell.nameLable.text = results.Name// Назначаем этот ответ текстом ячейки
        cell.lastnameLable.text = results.Lastname
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = result[indexPath.row]
        
        let storyboard = UIStoryboard(name: "ResultsStorybord", bundle: nil) // Тут исправлен неправильный нейминг Storyboard'а
        if let vc = storyboard.instantiateViewController(withIdentifier: "ReportVC") as? ReportVC {
            vc.selectedResult = selectedResult
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}

class ResultTableViewCell: UITableViewCell{
    @IBOutlet  weak var nameLable: UILabel!
    @IBOutlet  weak var lastnameLable: UILabel!
}
