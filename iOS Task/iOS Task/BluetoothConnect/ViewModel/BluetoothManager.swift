import CoreBluetooth
import SwiftUI

class BluetoothManager: NSObject, ObservableObject {
    
    private var centralManager: CBCentralManager!
    @Published var availableDevices: [CBPeripheral] = []
    @Published var connectedDevice: CBPeripheral?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func connect(to device: CBPeripheral) {
        centralManager.connect(device, options: nil)
    }
    
    func disconnect(from device: CBPeripheral) {
        centralManager.cancelPeripheralConnection(device)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
  
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
       
        switch central.state {
      
        case .poweredOn:
            central.scanForPeripherals(withServices: nil, options: nil)
       
        case .poweredOff, .resetting, .unauthorized, .unsupported, .unknown:
            print("Bluetooth state is not powered on")
        
        @unknown default:
            print("Unknown state")
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
       
        if !availableDevices.contains(peripheral) {
        
            availableDevices.append(peripheral)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        connectedDevice = peripheral
      
        print("Connected to \(peripheral.name ?? "unknown")")
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if connectedDevice == peripheral {
            connectedDevice = nil
        }
        print("Disconnected from \(peripheral.name ?? "unknown")")
    }
}

func centralManagerDidUpdateState(_ central: CBCentralManager) {
    
    switch central.state {
  
    case .poweredOff:
        print("Bluetooth is powered off")
    case .poweredOn:
        print("Bluetooth is powered on and ready")
        central.scanForPeripherals(withServices: nil, options: nil)
    case .resetting:
        print("Bluetooth is resetting")
    case .unauthorized:
        print("Bluetooth is unauthorized")
    case .unsupported:
        print("Bluetooth is unsupported on this device")
    case .unknown:
        print("Bluetooth state is unknown")
    @unknown default:
        print("A new state was added that we need to handle")
    }
}
