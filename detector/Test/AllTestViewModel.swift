import Foundation

final class AllTestViewModel{
    var bluetoothFinished: ((Bool) -> Void)?
    let bluetoothManager = BluetoothManagerProvider.shared.bluetoothManager
    private var calculat = CalculatingResult()
    func bluetoothStart(){
        bluetoothManager.receivedDataArray.removeAll()
        let message = "start"
        if let data = message.data(using: .utf8) {
            bluetoothManager.sendDataToPeripheral(data: data)
        }
    }
    func bluetoothStop() -> Bool{
        let message = "stop"
        if let data = message.data(using: .utf8) {
            bluetoothManager.sendDataToPeripheral(data: data)        }
     return calculat.responseResult(array: bluetoothManager.receivedDataArray, maxECG: XibTimers.maxECG)
    }
}
