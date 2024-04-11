import UIKit
import CoreBluetooth

class BluetoothManager: NSObject {
    var centralManager: CBCentralManager!
    var peripheralDevice: CBPeripheral!
    var characteristic: CBCharacteristic!
    let serviceUUID = CBUUID(string: "4fafc201-1fb5-459e-8fcc-c5c9c331914b")
    let characteristicUUID = CBUUID(string: "beb5483e-36e1-4688-b7f5-ea07361b26a8")
    var isConnected: Bool = false
    var receivedDataArray: [String] = []
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}
extension BluetoothManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            central.scanForPeripherals(withServices: [serviceUUID], options: nil)
        default:
            print("Bluetooth not available.")
        }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        isConnected = true
        print("Connected to peripheral: \(peripheral.name ?? "Unknown peripheral")")
        peripheral.delegate = self // Установите делегата здесь
        peripheral.discoverServices([serviceUUID])
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        print("Disconnected from peripheral: \(peripheral.name ?? "Unknown peripheral")")
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        peripheralDevice = peripheral
        centralManager.connect(peripheral)
    }
}
extension BluetoothManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics([characteristicUUID], for: service)
            }
        }
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == characteristicUUID {
                    self.characteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    //получение от esp
        func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
            guard let value = characteristic.value else {
                print("Received empty value from characteristic")
                return
            }
    
            if let dataString = String(data: value, encoding: .utf8) {
    
                receivedDataArray.append(dataString)
    
            } else {
                print("Unable to decode data to string")
            }
        }
    //отправка на esp
    func sendDataToPeripheral(data: Data) {
        if let peripheral = peripheralDevice, let characteristic = self.characteristic {
            if peripheral.state == .connected && characteristic.properties.contains(.write) {
                peripheral.writeValue(data, for: characteristic, type: .withResponse)
            } else {
                print("Peripheral or characteristic not available for sending data.")
            }
        } else {
            print("Peripheral or characteristic not available for sending data.")
        }
    }
}
class BluetoothManagerProvider {
    static let shared = BluetoothManagerProvider()
    let bluetoothManager = BluetoothManager()
    private init() {}
}
