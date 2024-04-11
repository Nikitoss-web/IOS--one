import UIKit
import CoreBluetooth

class TestVC: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator: UIActivityIndicatorView?
    let viewModel = TestViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupUI()
        bind()
        viewModel.fetchData()
    }
    @IBAction private func resultsButton(){
        let storyboard = UIStoryboard(name: Screen.resultStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ResultsVC.self)) as? ResultsVC {
            navigationController?.pushViewController(vc, animated: true)
        }}
    @IBAction private func exitButton(){
        KeychainManager.delete(account: AccountEnum.userToken.rawValue)
        let storyboard = UIStoryboard(name: Screen.main.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: ViewController.self)) as? ViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    private func bind(){
        viewModel.testLoaded = {
            self.tableView.reloadData()
            self.activityIndicator?.stopAnimating()
        }
    }
    private func setupUI() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator?.center = view.center
        view.addSubview(activityIndicator!)
        activityIndicator!.startAnimating()
        tableView.dataSource = self
        tableView.delegate = self
    }
}
extension TestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.testsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.yourCellIdentifier.rawValue , for: indexPath)
        cell.textLabel?.text = viewModel.testName(at: indexPath.row)
        return cell
    }
}
extension TestVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Screen.mainStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: SettingsVС.self)) as? SettingsVС {
            viewModel.settingsVCDelegate(objectId: viewModel.objectId(at: indexPath.row), testName:  viewModel.testName(at: indexPath.row), vcc: vc.viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
