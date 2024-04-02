import UIKit

class AllTestVC: UIViewController{
    @IBOutlet  weak var textLable: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    private var viewModel: AllTestViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AllTestViewModel()
        setupApperense()
        showTimersView()
        showButtons(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) { [self] in
            viewModel.bluetoothStart()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 18.0) { [self] in
            self.showButtons(true)
            recordAnswerResult(bool: updateResultView(viewModel.bluetoothStop()))
        }
    }
    @IBAction func noButtonTapped(_ sender: UIButton) {
        resultView.backgroundColor = .white
        recordAnswer(answer: "No")
        viewModel.bluetoothStart()
        showNextQuestion()
        showButtons(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            self.showButtons(true)
            recordAnswerResult(bool: updateResultView(viewModel.bluetoothStop()))
        }
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        resultView.backgroundColor = .white
        recordAnswer(answer: "Yes")
        showNextQuestion()
        viewModel.bluetoothStart()
      showButtons(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {[self] in
            self.showButtons(true)
            recordAnswerResult(bool: updateResultView(viewModel.bluetoothStop()))
        }
    }
    @IBAction func finishtestButton(){
        let storyboard = UIStoryboard(name: Screen.MainStorybord.rawValue, bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestVC.self)) as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func updateResultView(_ bool: Bool) -> Bool{
        resultView.backgroundColor = bool ? .green : .red
        return bool
    }
    private func recordAnswer(answer: String) {
        Manager.answers.append(answer)
    }
    
    private func recordAnswerResult( bool: Bool){
        let result = bool ? "Truth" : "Lie"
            Manager.answerResults.append(result)
    }
    private func showNextQuestion() {
        guard let currentQuestionIndex = Manager.questions.firstIndex(where: { $0 == textLable.text }) else {
            return
        }
        
        let nextQuestionIndex = currentQuestionIndex + 1
        if nextQuestionIndex < Manager.questions.count {
            let nextQuestion = Manager.questions[nextQuestionIndex]
            
            UIView.transition(with: textLable, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.textLable.text = nextQuestion
               
            }, completion: { _ in
                
            })
        } else {
            let storyboard = UIStoryboard(name: Screen.TestUserRegistration.rawValue, bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TestUserVC.self)) as? TestUserVC {
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    private func showTimersView(){
        if let xib = Bundle.main.loadNibNamed(Screen.XibTimers.rawValue, owner: self, options: nil)?.first as? XibTimers {
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
    private func setupApperense(){
        navigationItem.hidesBackButton = true
        resultView.backgroundColor = .white
        if let firstQuestion = Manager.questions.first {
            textLable.text = firstQuestion
        }
    }
    private func showButtons(_ show: Bool) {
        yesButton.isHidden = !show
        noButton.isHidden = !show
    }
   }

