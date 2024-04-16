import Foundation

class ECGData {
    
   public var receivedValues: [String] = []
    
    func storeReceivedValue(_ value: String) {
       receivedValues.append(value)
    }
}
