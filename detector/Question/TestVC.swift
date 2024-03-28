import UIKit
import CoreBluetooth

class TestVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: TestVCModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        viewModel = TestVCModel()
        setupUI()
        viewModel.fetchData(tableView: tableView)
    }
    private func setupUI() {
        viewModel.activityIndicator = UIActivityIndicatorView(style: .gray)
        viewModel.activityIndicator.center = view.center
        view.addSubview(viewModel.activityIndicator)
        viewModel.activityIndicator.startAnimating()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    @IBAction private func resultsButton(){
        let storyboard = UIStoryboard(name: "ResultsStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ResultsVC") as? ResultsVC {
            navigationController?.pushViewController(vc, animated: true)
        }}
    @IBAction private func exitButton(){
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.testsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier", for: indexPath)
        cell.textLabel?.text = viewModel.testName(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MainStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVС") as? SettingsVС {
            viewModel.transferSettingsVС(at: indexPath.row, viewController: vc)
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
