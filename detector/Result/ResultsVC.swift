import UIKit

protocol SelectedResultDelegatets: AnyObject{
    func ResultSelected(selectedResult: ViewResults?)
}
class ResultsVC: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var viewModel: ResultViewModel!
    var selectedResult: ViewResults?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ResultViewModel()
        viewModel.resultsData(userToken: KeychainManager.getPassword(for: AccountEnum.userToken.rawValue) ?? "", tableView: tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension ResultsVC: SelectedResultDelegatets{
    func ResultSelected(selectedResult: ViewResults?) {
        self.selectedResult = selectedResult
    }
}
extension ResultsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.yourCellIdentifier3.rawValue, for: indexPath) as? ResultTableViewCell
        cell?.nameLable.text = viewModel.resultName(at: indexPath.row)
        cell?.lastnameLable.text = viewModel.resultLastname(at: indexPath.row)
        return cell ?? UITableViewCell()
    }
}
extension ResultsVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Screen.resultStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ReportVC.self)) as? ReportVC {
           selectedResult = viewModel.results(at: indexPath.row)
            vc.selectedResult = selectedResult
            vc.delegates = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
class ResultTableViewCell: UITableViewCell{
    @IBOutlet  weak var nameLable: UILabel!
    @IBOutlet  weak var lastnameLable: UILabel!
}
