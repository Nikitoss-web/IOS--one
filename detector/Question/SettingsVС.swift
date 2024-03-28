import UIKit

class SettingsVС:  UIViewController, UITableViewDataSource,  UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var viewModel: SettingsViewModel!
    override func viewDidLoad() {
          super.viewDidLoad()
        viewModel = SettingsViewModel()
        setupUI()
        viewModel.updateData(withObjectId: SettingsViewModel.objectId ?? "", tableView: tableView)
      }

    private func setupUI() {
        viewModel.activityIndicator = UIActivityIndicatorView(style: .gray)
        viewModel.activityIndicator!.center = view.center
        view.addSubview(viewModel.activityIndicator!)
        viewModel.activityIndicator!.startAnimating()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchedQuestionsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier1", for: indexPath)
        cell.textLabel?.text = viewModel.question(at: indexPath.row)
        return cell
    }
    @IBAction private func startTestButton(){
        let storyboard = UIStoryboard(name: "AllTestStoryboard", bundle: nil)

        if let vc = storyboard.instantiateViewController(withIdentifier: "AllTestVC") as? AllTestVC {
            viewModel.startTest()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
