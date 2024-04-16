import UIKit

class TimersView: UIView {
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    var removeFromSuperviewClosure: (() -> Void)?
    static var maxECG:Int = 0
    static var arrayECG: [String] = []
    private let bluetoothManager = BluetoothManagerProvider.shared.bluetoothManager
    private var calculat = CalculatingResult()
    private var countdownTimer: Timer?
    private var secondsRemaining = 10
    
    override func awakeFromNib() {
        localizable()
        startCountdown()
    }
    
    @IBAction private func closeButtonTapped(_ sender: UIButton) {
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
                let message = TestResultEnum.messageStart.rawValue
                if let data = message.data(using: .utf8) {
                    bluetoothManager.sendDataToPeripheral(data: data)
                }
            } else {
                timer.invalidate()
                self.removeFromSuperviewClosure?()
                
                let message = TestResultEnum.messageStop.rawValue
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
    
    private func localizable() {
        stopButton.setTitle(NSLocalizedString("stop", comment: ""), for: .normal)
    }
}
