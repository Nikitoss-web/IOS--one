import Foundation
import UIKit

class ResultVCModel{
    private let resultsView = viewResult()
    var result: [ViewResults] = []
    var resultCount: Int {
        return result.count
    }
    func  results(at index: Int) -> ViewResults {
        return result[index]
    }
    func  resultName(at index: Int) -> String {
        return result[index].Name ?? ""
    }
    func  resultLastname(at index: Int) -> String {
        return result[index].Lastname ?? ""
    }
    func resultsData(userToken: String, tableView: UITableView){
        resultsView.viewResul(token: userToken, userId: String(decoding: KeychainManager.getPassword(for: "userId") ?? Data(), as: UTF8.self)) { [weak self] results in
            DispatchQueue.main.async {
                if let result = results {
                    self?.result = result
                    tableView.reloadData()
                } else {
                    print("Ошибка при получении результатов")
                }
            }}}
}
