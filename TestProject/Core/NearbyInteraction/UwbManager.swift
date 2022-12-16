//
//  UwbService.swift
//  TestProject
//
//  Created by Jaafar on 12/12/2022.
//

import Foundation
import NearbyInteraction
import CoreBluetooth

class UwbManager : NSObject {
    var bleManager: BleManager!
    var configMap: [NIDiscoveryToken : CBPeripheral] = [:]
    var sessionMap: [UUID : NISession] = [:]
    var nearbyObjectMap: [NIDiscoveryToken : NINearbyObject] = [:]
    
    var accessoryDidUpdateDistanceHandler: ((Float, CBPeripheral) -> Void)?
    
    static let shared = UwbManager()
    
    private override init() {
        super.init()
    }
    
    deinit {
        print("UwbManager was de-initialised")
    }
    
    func setupBleManager(manager: BleManager) {
        self.bleManager = manager
    }
    
    func initUwbConnection(for peripheral: CBPeripheral?) {
        let msg = Data([UwbMessageId.initialize.rawValue])
        
        do {
            try bleManager.sendData(msg, to: peripheral)
        } catch {
            print("Failed to send init data to peripheral")
        }
    }
    
    func isUwbConnected(to peripheral: CBPeripheral?) -> Bool {
        guard
            let peripheral = peripheral,
            let session = sessionMap[peripheral.identifier],
            let key = session.discoveryToken,
            let _ = nearbyObjectMap[key]
        else {
            return false
        }
        
        return true
    }
    
    func getDistance(to peripheral: CBPeripheral?) -> Float? {
        guard
            let peripheral = peripheral,
            let session = sessionMap[peripheral.identifier],
            let key = session.discoveryToken,
            let nearbyObject = nearbyObjectMap[key]
        else {
            return nil
        }
        
        return nearbyObject.distance
    }
    
    func accessorySharedData(data: Data, to peripheral: CBPeripheral) {
        if data.count < 1 {
            return
        }
        
        // Assign the first byte which is the message identifier.
        guard let messageId = UwbMessageId(rawValue: data.first!) else {
            fatalError("\(data.first!) is not a valid MessageId.")
        }
        
        // Handle the data portion of the message based on the message identifier.
        switch messageId {
        case .accessoryConfigurationData:
            // Access the message data by skipping the message identifier.
            assert(data.count > 1)
            let message = data.advanced(by: 1)
            setupAccessory(message, to: peripheral)
        case .accessoryUwbDidStart:
            print("Accessory did start")
        case .accessoryUwbDidStop:
            print("Accessory did stop")
        case .configureAndStart:
            fatalError("Accessory should not send 'configureAndStart'.")
        case .initialize:
            fatalError("Accessory should not send 'initialize'.")
        case .stop:
            fatalError("Accessory should not send 'stop'.")
        }
    }
    
    func setupAccessory(_ configData: Data, to peripheral: CBPeripheral) {
        let config: NINearbyAccessoryConfiguration?
        do {
            config = try NINearbyAccessoryConfiguration(data: configData)
        } catch {
            print("Something is wrong with the setup - it will not work")
            return
        }
        
        if let configuration = config {
            if sessionMap[peripheral.identifier] == nil {
                sessionMap[peripheral.identifier] = NISession()
            }
            
            guard let session = sessionMap[peripheral.identifier] else { return }
            
            if let token = session.discoveryToken {
                configMap[token] = peripheral
                session.delegate = self
                session.run(configuration)
            }
        }
    }
}

extension UwbManager : NISessionDelegate {
    func session(_ session: NISession, didGenerateShareableConfigurationData shareableConfigurationData: Data, for object: NINearbyObject) {
        
        let peripheral = getPeripheral(for: session.discoveryToken)
        
        // Prepare to send a message to the accessory.
        var msg = Data([UwbMessageId.configureAndStart.rawValue])
        msg.append(shareableConfigurationData)
        
        do {
            try bleManager.sendData(msg, to: peripheral)
            
            if let token = session.discoveryToken {
                nearbyObjectMap[token] = object
            }
        } catch {
           print("Failed to Configure and start UWB")
        }
    }
    
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        guard let token = session.discoveryToken else { return }
        guard let nearbyObject = nearbyObjectMap[token] else { return }
        guard let accessory = nearbyObjects.first(where: { object in object.discoveryToken == nearbyObject.discoveryToken }) else {
            print("Failed to find the object in array of nearbyObjects - cannot get distance")
            return
        }
        guard let distance = accessory.distance else { return }
        
        if
            let accessoryDidUpdateDistanceHandler = accessoryDidUpdateDistanceHandler,
            let token = session.discoveryToken,
            let peripheral = configMap[token]
        {
            accessoryDidUpdateDistanceHandler(distance, peripheral)
        }
    }
    
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        print("Session was disconnected. Reason:", reason.rawValue)
        
        if reason == .timeout {
            do {
                let peripheral = getPeripheral(for: session.discoveryToken)
                try bleManager.sendData(Data([UwbMessageId.stop.rawValue]), to: peripheral)
                try bleManager.sendData(Data([UwbMessageId.initialize.rawValue]), to: peripheral)
            } catch {
                print("Failed to establish connection after timeout")
            }
        }
    }
    
    func session(_ session: NISession, didInvalidateWith error: Error) {
        print("There was an error", error)
    }
    
    func sessionWasSuspended(_ session: NISession) {
        let msg = Data([UwbMessageId.stop.rawValue])
        
        do {
            try bleManager.sendData(msg, to: getPeripheral(for: session.discoveryToken))
        } catch {
            print("Failed to stop connection when suspended")
        }
        
    }
    
    func sessionSuspensionEnded(_ session: NISession) {
        let msg = Data([UwbMessageId.initialize.rawValue])
        do {
            try bleManager.sendData(msg, to: getPeripheral(for: session.discoveryToken))
        } catch {
            print("Failed to establish connection after suspension ended")
        }
    }
    
    private func getPeripheral(for key: NIDiscoveryToken?) -> CBPeripheral? {
        guard let key = key else { return nil }
        
        if !configMap.keys.contains(key) {
            return nil
        }
        
        return configMap[key]
    }
}
