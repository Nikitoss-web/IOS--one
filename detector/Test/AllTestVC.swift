import UIKit

class AllTestVC: UIViewController{
    
    
    
    
    @IBOutlet  weak var textLable: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var resultView: UIView!
    var objectId: String?
    var questions: [String] = []
    var answers: [String] = []
    var responseResult: [String] = []
    var calculat = CalculatingResult()
//    var simpleBluetoothIO = BluetoothManager()
    var simpleBluetoothIO: BluetoothManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        resultView.backgroundColor = .white
        simpleBluetoothIO = BluetoothManager()
        if let firstQuestion = questions.first {
            textLable.text = firstQuestion
        }
        

        showButtons(false)
        
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 12.0) { [self] in
            simpleBluetoothIO.receivedDataArray.removeAll()
            let message = "start"
            if let data = message.data(using: .utf8) {
                simpleBluetoothIO.sendDataToPeripheral(data: data)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 18.0) { [self] in
            self.showButtons(true)
            let message = "stop"
            if let data = message.data(using: .utf8) {
                simpleBluetoothIO.sendDataToPeripheral(data: data)
            }
           calculat.responseResult(resultView: resultView, array: simpleBluetoothIO.receivedDataArray, maxECG: XibTimers.maxECG)
            simpleBluetoothIO.receivedDataArray.removeAll()

        }
        
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
        resultView.backgroundColor = .white
        recordAnswer(answer: "No")
        let message = "start"
        if let data = message.data(using: .utf8) {
            simpleBluetoothIO.sendDataToPeripheral(data: data)
        }
        showNextQuestion()
        showButtons(false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [self] in
            self.showButtons(true)
            let message = "stop"
            if let data = message.data(using: .utf8) {
                simpleBluetoothIO.sendDataToPeripheral(data: data)
            }
          calculat.responseResult(resultView: resultView, array: simpleBluetoothIO.receivedDataArray, maxECG: XibTimers.maxECG)
            simpleBluetoothIO.receivedDataArray.removeAll()

        }
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        resultView.backgroundColor = .white
        recordAnswer(answer: "Yes")
        showNextQuestion()
        let message = "start"
        if let data = message.data(using: .utf8) {
            simpleBluetoothIO.sendDataToPeripheral(data: data)
        }
      showButtons(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {[self] in
            self.showButtons(true)
            let message = "stop"
            if let data = message.data(using: .utf8) {
               simpleBluetoothIO.sendDataToPeripheral(data: data)
            }
           calculat.responseResult(resultView: resultView, array: simpleBluetoothIO.receivedDataArray, maxECG: XibTimers.maxECG)
            simpleBluetoothIO.receivedDataArray.removeAll()

        }
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
    
    //    private func showNextQuestion() {
    //        guard let currentQuestionIndex = questions.firstIndex(where: { $0 == textLable.text }) else {
    //            return
    //        }
    //
    //        let nextQuestionIndex = currentQuestionIndex + 1
    //        if nextQuestionIndex < questions.count {
    //            let nextQuestion = questions[nextQuestionIndex]
    //
    //            UIView.transition(with: textLable, duration: 0.5, options: .transitionCrossDissolve, animations: {
    //                self.textLable.text = nextQuestion
    //            }, completion: nil)
    //        } else {
    //            let storyboard = UIStoryboard(name: "TestUserRegistration", bundle: nil)
    //            if let vc = storyboard.instantiateViewController(withIdentifier: "TestUserVC") as? TestUserVC {
    //                vc.questions = questions
    //                vc.answers = answers
    //                navigationController?.pushViewController(vc, animated: true)
    //            }
    //        }}
    //
    
    private func showNextQuestion() {
        guard let currentQuestionIndex = questions.firstIndex(where: { $0 == textLable.text }) else {
            return
        }
        
        let nextQuestionIndex = currentQuestionIndex + 1
        if nextQuestionIndex < questions.count {
            let nextQuestion = questions[nextQuestionIndex]
            
            UIView.transition(with: textLable, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.textLable.text = nextQuestion
               
            }, completion: { _ in
                // Delay showing the buttons by 1 second
                
            })
        } else {
            let storyboard = UIStoryboard(name: "TestUserRegistration", bundle: nil)
            if let vc = storyboard.instantiateViewController(withIdentifier: "TestUserVC") as? TestUserVC {
                vc.questions = questions
                vc.answers = answers
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    private func showButtons(_ show: Bool) {
        // Set button visibility based on the show parameter
        yesButton.isHidden = !show
        noButton.isHidden = !show
    }
   }

