import UIKit

class SettingsVС:  UIViewController, UITableViewDelegate {
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let viewModel =  SettingsViewModel(nameTest: OnlineNameTestAPI())
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
          super.viewDidLoad()
        localizable()
        setupUI()
        bind() 
        viewModel.updateData()
      }
    
    @IBAction private func startTestButton() {
        let storyboard = UIStoryboard(name: Screen.allTestStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: AllTestVC.self)) as? AllTestVC {
            viewModel.startTest(fetchedQuestion: viewModel.fetchedQuestion, vc: vc.viewModel)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func bind() {
        viewModel.testLoaded = {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
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
    
    private func localizable() {
        startButton.setTitle(NSLocalizedString("start_test", comment: ""), for: .normal)
    }
}

extension SettingsVС: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchedQuestionsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.yourCellIdentifier1.rawValue , for: indexPath)
        cell.textLabel?.text = viewModel.question(at: indexPath.row)
        return cell
    }
}
