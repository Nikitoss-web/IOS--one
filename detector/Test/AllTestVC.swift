import UIKit

class AllTestVC: UIViewController{
    @IBOutlet weak var finishsButton: UIButton!
    @IBOutlet  weak var textLable: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    var viewModel =  AllTestViewModel(calculat: CalculatingResult())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizable()
        setupAppearance()
        showTimersView()
        showButtons(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) { [self] in
            viewModel.bluetoothStart()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 18.0) { [self] in
            self.showButtons(true)
            viewModel.recordAnswerResult(bool: updateResultView(viewModel.bluetoothStop()))
        }
    }
    
    func updateResultView(_ bool: Bool) -> Bool {
        resultView.backgroundColor = bool ? .green : .red
        return bool
    }
    
    @IBAction private func noButtonTapped(_ sender: UIButton) {
        resultView.backgroundColor = .white
        viewModel.recordAnswer(answer: TestResultEnum.no.rawValue)
        viewModel.bluetoothStart()
        showNextQuestion()
        showButtons(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            self.showButtons(true)
            viewModel.recordAnswerResult(bool: updateResultView(viewModel.bluetoothStop()))
        }
    }
    
    @IBAction private func yesButtonTapped(_ sender: UIButton) {
        resultView.backgroundColor = .white
        viewModel.recordAnswer(answer: TestResultEnum.yes.rawValue)
        showNextQuestion()
        viewModel.bluetoothStart()
        showButtons(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {[self] in
            self.showButtons(true)
            viewModel.recordAnswerResult(bool: updateResultView(viewModel.bluetoothStop()))
        }
    }
    
    @IBAction private func finishtestButton() {
        let storyboard = UIStoryboard(name: Screen.mainStoryboard.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestVC.self)) as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func showNextQuestion() {
        if viewModel.currentQuestionIndex(textLabel: textLable.text ?? "") < viewModel.fetchedQuestions.count {
            UIView.transition(with: textLable, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.textLable.text = self.viewModel.fetchedQuestions[self.viewModel.currentQuestionIndex(textLabel: self.textLable.text ?? "")]
            }, completion: { _ in
            })
        } else {
            let storyboard = UIStoryboard(name: Screen.testUserRegistration.rawValue, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestUserVC.self)) as? TestUserVC {
                viewModel.delegateAllTestViewModel(vc: vc.viewModel)
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    private func showTimersView() {
        if let xib = Bundle.main.loadNibNamed(Screen.timersView.rawValue, owner: self, options: nil)?.first as? TimersView {
            let dimView = UIView(frame: view.bounds)
            dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.addSubview(dimView)
            
            xib.frame = CGRect(x: (view.frame.width - xib.frame.width) / 2, y: (view.frame.height - xib.frame.height) / 2, width: xib.frame.width, height: xib.frame.height)
            view.addSubview(xib)
            
            xib.removeFromSuperviewClosure = {
                xib.removeFromSuperview()
                dimView.removeFromSuperview()
            }
        }
    }
    
    private func setupAppearance() {
        navigationItem.hidesBackButton = true
        resultView.backgroundColor = .white
        if let firstQuestion = viewModel.fetchedQuestions.first {
            textLable.text = firstQuestion
        }
    }
    
    private func showButtons(_ show: Bool) {
        yesButton.isHidden = !show
        noButton.isHidden = !show
    }
    
    private func localizable(){
        finishsButton.setTitle(NSLocalizedString("finish_test", comment: ""), for: .normal)
        yesButton.setTitle(NSLocalizedString("yes", comment: ""), for: .normal)
        noButton.setTitle(NSLocalizedString("no", comment: ""), for: .normal)
    }
}
