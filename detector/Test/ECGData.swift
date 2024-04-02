import Foundation

class ECGData {
   public var receivedValues: [String] = []
    func storeReceivedValue(_ value: String) {
       receivedValues.append(value)
    }
    func printReceivedValues() {
        for value in receivedValues {
            print("массив: \(value)")
        }
    }
}
