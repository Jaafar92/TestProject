//
//  DataCommunicationChannel.swift
//  TestProject
//
//  Created by Jaafar on 07/12/2022.
//

import Foundation
import CoreBluetooth
import os

enum BluetoothLECentralError: Error {
    case noPeripheral
}

// Needs to be an NSObject to be able to use the CBCentralManagerDelegate
class BleManager : NSObject {
    
    // The CoreBluetooth Manager to be used for everything
    var centralManager: CBCentralManager!
    var discoveredPeripherals: [BleProduct]!
    
    // Characteristics for receiving and transmitting data
    // Note: this is not the UUID, but the actual characteristic that communicate with
    var rxCharacteristic: CBCharacteristic?
    var txCharacteristic: CBCharacteristic?
    
    // Variables to know if we should start Bluetooth
    var bluetoothReady = false
    var shouldStartWhenReady = false
    
    // Handlers for when event occour - it is functions to run when certain things happen
    // These are optionals and only for UI purpose
    var accessoryDataHandler: ((Data, CBPeripheral) -> Void)?
    var accessoryUpdatedWithNewPeripheral: (([BleProduct]) -> Void)?
    var accessoryDidConnectHandler: ((CBPeripheral) -> Void)?
    var accessoryDidDisconnectHandler: ((CBPeripheral) -> Void)?
    
    // This and the private init is to make it a singleton
    static let shared = BleManager()
        
    private override init() {
        super.init()
        discoveredPeripherals = [BleProduct]()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: true])
        print("Central Manager has been initialised")
    }
    
    deinit {
        centralManager.stopScan()
        print("Central Manager has stopped all scans")
    }
    
    func connect(peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
    }
    
    func disconnect(peripheral: CBPeripheral) {
        centralManager.cancelPeripheralConnection(peripheral)
    }
    
    func startScanning() {
        if centralManager.isScanning {
            print("Already scanning")
            return
        }
        
        centralManager.scanForPeripherals(withServices: [UwbConstants.serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
        print("Scanning started")
    }
    
    func stopScanning() {
        centralManager.stopScan()
        print("Scanning stopped")
    }
    
    
    func start() {
        if bluetoothReady {
            retrievePeripheral()
        } else {
            shouldStartWhenReady = true
        }
    }
    
    func sendData(_ data: Data, to peripheral: CBPeripheral?) throws {
        writeData(data, to: peripheral)
    }
    
    // Sends data to the peripheral.
    // After we have connected to the periphiral, we need to send some data to
    // initiate the UWB conenction
    private func writeData(_ data: Data, to peripheral: CBPeripheral?) {

        guard let transferCharacteristic = rxCharacteristic else { return }
        guard let peripheral = peripheral else { return }

        let mtu = peripheral.maximumWriteValueLength(for: .withResponse)

        let bytesToCopy: size_t = min(mtu, data.count)

        var rawPacket = [UInt8](repeating: 0, count: bytesToCopy)
        data.copyBytes(to: &rawPacket, count: bytesToCopy)
        let packetData = Data(bytes: &rawPacket, count: bytesToCopy)

        let stringFromData = packetData.map { String(format: "0x%02x, ", $0) }.joined()
        print("Writing \(bytesToCopy) bytes: \(String(describing: stringFromData))")

        peripheral.writeValue(packetData, for: transferCharacteristic, type: .withResponse)
    }
    
    // Scan for peripherals
    private func retrievePeripheral() {
        centralManager.scanForPeripherals(withServices: [UwbConstants.serviceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])
    }
    
    
    // Unsubscribe and disconnect from periphiral
    private func cleanup(_ peripheral: CBPeripheral) {
        
        // Stop listening for notifications if we do
        for service in (peripheral.services ?? [] as [CBService]) {
            for characteristic in (service.characteristics ?? [] as [CBCharacteristic]) {
                if characteristic.uuid == UwbConstants.rxCharacteristicUUID && characteristic.isNotifying {
                    // It is notifying, so unsubscribe
                    peripheral.setNotifyValue(false, for: characteristic)
                }
            }
        }

        // When a connection exists without a subscriber, only disconnect.
        centralManager.cancelPeripheralConnection(peripheral)
        
        // Remove from the discovered peripherals
        discoveredPeripherals.removeAll { product in
            product.peripheral.identifier == peripheral.identifier
        }
    }
}

extension BleManager : CBCentralManagerDelegate {
    
    /// Callback to when the CB manager updates its state. This happens after 'centralManager.scanForPeripherals'
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .unauthorized:
                handleCBUnauthorized()
                return
            case .poweredOn:
                startBluetooth()
                return
                // In your app, deal with the following states as necessary.
            case .poweredOff:
                print("CBManager is not powered on")
                return
            case .resetting:
                print("CBManager is resetting")
                return
            case .unknown:
                print("CBManager state is unknown")
                return
            case .unsupported:
                print("Bluetooth is not supported on this device")
                return
            @unknown default:
                print("A previously unknown central manager state occurred")
                return
        }
    }
    
    // Keep track of all discovered peripherals
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        let results = discoveredPeripherals.filter { $0.bleUuid == peripheral.identifier }
        
        if results.isEmpty {
            print("Added peripheral", peripheral.name ?? "Unkown")
            discoveredPeripherals.append(BleProduct(with: peripheral))
            
            if let accessoryUpdatedWithNewPeripheral = accessoryUpdatedWithNewPeripheral {
                accessoryUpdatedWithNewPeripheral(discoveredPeripherals)
            }
        }
    }
    
    // If we fail to connect, we clean up
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to \(peripheral). \( String(describing: error))")
        cleanup(peripheral)
    }
    
    // Discovers the services and characteristics to find the 'UwbConstants'
    // characteristic after peripheral connection.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        // Notify the UI through the handler
        if let accessoryDidConnectHandler = accessoryDidConnectHandler {
            accessoryDidConnectHandler(peripheral)
        }

        // Set the `CBPeripheral` delegate to receive callbacks for its services discovery.
        peripheral.delegate = self
        
        // Search only for services that match the service UUID.
        // When we discover the serivce, the delegate will be called
        peripheral.discoverServices([UwbConstants.serviceUUID])
    }
    
    // Cleans up the local copy of the peripheral after disconnection.
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Perhiperal Disconnected")
        
        if let accessoryDidDisconnectHandler = accessoryDidDisconnectHandler {
            accessoryDidDisconnectHandler(peripheral)
        }
        
        discoveredPeripherals.removeAll { product in
            product.peripheral.identifier == peripheral.identifier
        }
    }
    
    private func startBluetooth() {
        print("CBManager is powered on")
        print("Permission to use CB has been granted")
        bluetoothReady = true
        if shouldStartWhenReady {
            start()
        }
    }
    
    private func handleCBUnauthorized() {
        switch CBManager.authorization {
        case .denied:
            // In your app, consider sending the user to Settings to change authorization.
            print("The user denied Bluetooth access.")
        case .restricted:
            print("Bluetooth is restricted")
        default:
            print("Unexpected authorization")
        }
    }
}

extension BleManager: CBPeripheralDelegate {
    
    // Reacts to peripheral services discovery.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        // Return and clean up if there is an error
        if let error = error {
            print("Error discovering services: \(error.localizedDescription)")
            cleanup(peripheral)
            return
        }
        
        print("discovered service. Now discovering characteristics")
        
        // Check the newly filled peripheral services array for more services.
        guard let peripheralServices = peripheral.services else { return }
        for service in peripheralServices {
            peripheral.discoverCharacteristics([UwbConstants.rxCharacteristicUUID, UwbConstants.txCharacteristicUUID], for: service)
        }
    }
    
    // Subscribes to a discovered characteristic, which lets the peripheral know we want the data it contains.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        // Return and clean up for any error
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            cleanup(peripheral)
            return
        }

        // Check the newly filled peripheral services array for more services.
        guard let serviceCharacteristics = service.characteristics else { return }
        for characteristic in serviceCharacteristics where characteristic.uuid == UwbConstants.rxCharacteristicUUID {
            // Subscribe to the transfer service's `rxCharacteristic`.
            rxCharacteristic = characteristic
            print("discovered characteristic: \(characteristic)")
            peripheral.setNotifyValue(true, for: characteristic)
        }
        
        for characteristic in serviceCharacteristics where characteristic.uuid == UwbConstants.txCharacteristicUUID {
            // Subscribe to the transfer service's `rxCharacteristic`.
            txCharacteristic = characteristic
            print("discovered characteristic: \(characteristic)")
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    // Reacts to data arrival through the characteristic notification.
    // After we started to listen for notification we expect to get data here
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        // Return and clean up for any error
        if let error = error {
            print("Error discovering characteristics:\(error.localizedDescription)")
            cleanup(peripheral)
            return
        }
        
        guard let characteristicData = characteristic.value else { return }
    
        let str = characteristicData.map { String(format: "0x%02x, ", $0) }.joined()
        print("Received \(characteristicData.count) bytes: \(str)")
        
        if let dataHandler = self.accessoryDataHandler {
            dataHandler(characteristicData, peripheral)
        }
    }
    
    // Reacts to the subscription status.
    // This is just for reading status of notification state changed
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        // Check if the peripheral reported an error.
        if let error = error {
            print("Error changing notification state: \(error.localizedDescription)")
            return
        }

        if characteristic.isNotifying {
            // Indicates the notification began.
            print("Notification began on \(characteristic)")
        } else {
            // Because the notification stopped, disconnect from the peripheral.
            print("Notification stopped on \(characteristic). Disconnecting")
            cleanup(peripheral)
        }
    }
    
    // Reacts to peripheral services invalidation.
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {

        for service in invalidatedServices where service.uuid == UwbConstants.serviceUUID {
            print("Transfer service is invalidated - rediscover services")
            peripheral.discoverServices([UwbConstants.serviceUUID])
        }
    }
}
