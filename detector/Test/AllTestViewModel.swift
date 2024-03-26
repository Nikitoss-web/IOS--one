//
//  AllTestViewModel.swift
//  detector
//
//  Created by НИКИТА ПЕСНЯК on 22.03.24.
//

import Foundation

final class AllTestViewModel{
    private var simpleBluetoothIO = BluetoothManager()
    private var calculat = CalculatingResult()
    var bluetoothFinished: ((Bool) -> Void)?
    
    func bluetoothStart(){
        simpleBluetoothIO.receivedDataArray.removeAll()
        let message = "start"
        if let data = message.data(using: .utf8) {
            simpleBluetoothIO.sendDataToPeripheral(data: data)
        }
    }
    func bluetoothStop() -> Bool{
        let message = "stop"
        if let data = message.data(using: .utf8) {
            simpleBluetoothIO.sendDataToPeripheral(data: data)
        }
     return calculat.responseResult(array: simpleBluetoothIO.receivedDataArray, maxECG: XibTimers.maxECG)
    }
}
