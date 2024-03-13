import UIKit

class AllTestVC: UIViewController {
    @IBOutlet  weak var textLable: UILabel!

    //var questionObjects: [Question] = []
    var objectId: String?
    var questions: [String] = []
    var answers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        if let firstQuestion = questions.first {
                textLable.text = firstQuestion
            }
        if let xib = Bundle.main.loadNibNamed("XibTimers", owner: self, options: nil)?.first as? XibTimers {
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
    @IBAction func noButtonTapped(_ sender: UIButton) {
        recordAnswer(answer: "No")
        showNextQuestion()
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        recordAnswer(answer: "Yes")
        showNextQuestion()
    }
    @IBAction func finishtestButton(){
        let storyboard = UIStoryboard(name: "MainStorybord", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "TestVC") as? TestVC {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
 
    private func recordAnswer(answer: String) {
           answers.append(answer) // Записываем ответ в массив answers
       }
       
    private func showNextQuestion() {
        guard let currentQuestionIndex = questions.firstIndex(where: { $0 == textLable.text }) else {
            return
        }
        
        let nextQuestionIndex = currentQuestionIndex + 1
        if nextQuestionIndex < questions.count {
            let nextQuestion = questions[nextQuestionIndex]
            
            UIView.transition(with: textLable, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.textLable.text = nextQuestion
            }, completion: nil)
        } else {
            let storyboard = UIStoryboard(name: "TestUserRegistration", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "TestUserVC") as? TestUserVC {
                vc.questions = questions
                vc.answers = answers
                navigationController?.pushViewController(vc, animated: true)
            }
        }}
        
    }
