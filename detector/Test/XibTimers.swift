////
////  XibTimers.swift
////  detector
////
////  Created by НИКИТА ПЕСНЯК on 11.03.24.
////
//
//import UIKit
//
//class XibTimers: UIView {
////    @IBOutlet var contentView: UIView!
//    
//    @IBOutlet weak var nameTimes: UILabel!
//    private var timer: Timer?
//       private var time: TimeInterval = 0.0 {
//           didSet {
//               nameTimes.text = String(format: "%.1f", time)
//           }
//       }
//       
//       required init?(coder aDecoder: NSCoder) {
//           super.init(coder: aDecoder)
//           commonInit()
//       }
//       
//       private func commonInit() {
//           let nib = UINib(nibName: "XibTimers", bundle: Bundle(for: type(of: self)))
//           if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
//               view.frame = bounds
//               view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//               addSubview(view)
//           }
//       }
//       
//    @IBAction func startButton(_ sender: Any) {
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
//                    guard let self = self else { return }
//                    self.time += 0.1
//                }
//    }
//    @IBAction func stopButton(_ sender: Any) {
//        timer?.invalidate()
//        time = 0.0
//    }
//    deinit { // Этот метод вызывается при уничтожении объекта
//           timer?.invalidate() // Остановить таймер перед уничтожением объекта
//       }
//   
//}







import UIKit

class XibTimers: UIView {
    @IBOutlet private weak var timerLabel: UILabel!
    
    private var countdownTimer: Timer?
    private var secondsRemaining = 10
    var removeFromSuperviewClosure: (() -> Void)?
       
       override func awakeFromNib() {
           super.awakeFromNib()
           startCountdown()
       }
       
       private func startCountdown() {
           countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
               guard let self = self else { return }
               if self.secondsRemaining > 0 {
                   self.secondsRemaining -= 1
                   self.timerLabel.text = "\(self.secondsRemaining)"
               } else {
                   timer.invalidate()
                   self.removeFromSuperviewClosure?() 
                   

               }
           }
       }
       
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        countdownTimer?.invalidate()
        self.removeFromSuperview()
        self.removeFromSuperviewClosure?()
    }
}
