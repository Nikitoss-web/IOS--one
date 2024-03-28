import UIKit

class ResultsVC: UIViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ResultVCModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ResultVCModel()
        tableView.dataSource = self
        viewModel.resultsData(userToken: String(decoding: KeychainManager.getPassword(for: "userToken") ?? Data(), as: UTF8.self), tableView: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier3", for: indexPath) as! ResultTableViewCell
        
        //let results = result[indexPath.row]
        cell.nameLable.text = viewModel.resultName(at: indexPath.row)
        cell.lastnameLable.text = viewModel.resultLastname(at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let selectedResult = viewModel.results(at: indexPath.row)
        
        let storyboard = UIStoryboard(name: "ResultsStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ReportVC") as? ReportVC {
            ReportVCModel.selectedResult = viewModel.results(at: indexPath.row)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
class ResultTableViewCell: UITableViewCell{
    @IBOutlet  weak var nameLable: UILabel!
    @IBOutlet  weak var lastnameLable: UILabel!
}
