import Foundation
import UIKit

protocol SelectedResultDelegatets: AnyObject{
    
    func ResultSelected(selectedResult: ViewResults?)
}

class ResultViewModel{
    var selectedResult: ViewResults?
    private var result: [ViewResults] = []
    private let resultsView: ViewResultss
    
    init (resultsView: ViewResultss) {
        self.resultsView = resultsView
    }
    
   
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
    
    func resultsData(userToken: String, tableView: UITableView) {
        resultsView.viewResult(token: userToken, userId: KeychainManager.getPassword(for: AccountEnum.userId.rawValue) ?? "") { [weak self] (result: Result<[ViewResults]?, ErrorAPI>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    if let results = results {
                        self?.result = results
                        tableView.reloadData()
                    }
                case .failure(let error):
                    print("Ошибка при получении результатов: \(error)")
                }
            }
        }
    }
    
    func flashResult(vc: ReportViewModel, at index: Int) {
        vc.selectedResult = results(at: index)
        vc.delegates = self
        vc.delegates?.ResultSelected(selectedResult: vc.selectedResult)
    }
}

extension ResultViewModel: SelectedResultDelegatets {
    func ResultSelected(selectedResult: ViewResults?) {
        self.selectedResult = selectedResult
    }
}
