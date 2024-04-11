import UIKit

class TimersView: UIView {
    @IBOutlet private weak var timerLabel: UILabel!
    var removeFromSuperviewClosure: (() -> Void)?
    let bluetoothManager = BluetoothManagerProvider.shared.bluetoothManager
    var calculat = CalculatingResult()
    static var maxECG:Int = 0
    static var arrayECG: [String] = []
    private var countdownTimer: Timer?
    private var secondsRemaining = 10
       override func awakeFromNib() {
           startCountdown()
       }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        countdownTimer?.invalidate()
        self.removeFromSuperview()
        self.removeFromSuperviewClosure?()
    }
    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.secondsRemaining > 0 {
                self.secondsRemaining -= 1
                self.timerLabel.text = "\(self.secondsRemaining)"
                let message = "start"
                if let data = message.data(using: .utf8) {
                    bluetoothManager.sendDataToPeripheral(data: data)
                }
            } else {
                timer.invalidate()
                self.removeFromSuperviewClosure?()
                
                let message = "stop"
                if let data = message.data(using: .utf8) {
                    bluetoothManager.sendDataToPeripheral(data: data)
                }
                TimersView.arrayECG = bluetoothManager.receivedDataArray
                print(bluetoothManager.receivedDataArray)
                TimersView.maxECG = calculat.maxArray(StringArray: bluetoothManager.receivedDataArray) ?? 0
                bluetoothManager.receivedDataArray.removeAll()
            }
        }
    }
}
