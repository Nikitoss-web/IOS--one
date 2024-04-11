import Foundation
import UIKit

class ResultViewModel{
    var result: [ViewResults] = []
    private let resultsView = ViewResultAPI()
    var resultCount: Int {
        return result.count
    }
    func  results(at index: Int) -> ViewResults {
        return result[index]
    }
    func  resultName(at index: Int) -> String {
        return result[index].name ?? ""
    }
    func  resultLastname(at index: Int) -> String {
        return result[index].lastname ?? ""
    }
    func resultsData(userToken: String, tableView: UITableView){
        resultsView.viewResult(token: userToken, userId: KeychainManager.getPassword(for: AccountEnum.userId.rawValue) ?? "") { [weak self] results in
            DispatchQueue.main.async {
                if let result = results {
                    self?.result = result
                    tableView.reloadData()
                } else {
                    print("Ошибка при получении результатов")
                }
            }}}
}
