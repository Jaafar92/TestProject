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
    var dataCommunicationChannel: DataCommunicationChannel!
    var niSession: NISession = NISession()
    var configuration: NINearbyAccessoryConfiguration?
    var configMap: [NIDiscoveryToken : CBPeripheral] = [:]
    
    var accessoryDidUpdateDistanceHandler: ((Float) -> Void)?
    
    init(dataCommunicationChannel: DataCommunicationChannel) {
        super.init()
        niSession.delegate = self
        self.dataCommunicationChannel = dataCommunicationChannel
    }
    
    func initUwbConnection(for peripheral: CBPeripheral?) {
        let msg = Data([UwbMessageId.initialize.rawValue])
        
        do {
            try dataCommunicationChannel.sendData(msg, to: peripheral)
        } catch {
            print("Failed to send init data to peripheral")
        }
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
        do {
            configuration = try NINearbyAccessoryConfiguration(data: configData)
        } catch {
            print("Something is wrong with the setup - it will not work")
            return
        }
        
        if let configuration = configuration {
            configMap[configuration.accessoryDiscoveryToken] = peripheral
            niSession.run(configuration)
        }
    }
}

extension UwbManager : NISessionDelegate {
    func session(_ session: NISession, didGenerateShareableConfigurationData shareableConfigurationData: Data, for object: NINearbyObject) {
        
        let peripheral = getPeripheral(for: object.discoveryToken)
        
        // Prepare to send a message to the accessory.
        var msg = Data([UwbMessageId.configureAndStart.rawValue])
        msg.append(shareableConfigurationData)
        
        do {
            try dataCommunicationChannel.sendData(msg, to: peripheral)
        } catch {
           print("Failed to Configure and start UWB")
        }
    }
    
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        guard let accessory = nearbyObjects.first else { return }
        guard let distance = accessory.distance else { return }
        
        if let accessoryDidUpdateDistanceHandler = accessoryDidUpdateDistanceHandler {
            accessoryDidUpdateDistanceHandler(distance)
        }
    }
    
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        print("Session was disconnected. Reason:", reason.rawValue)
        
        if reason == .timeout {
            do {
                for object in nearbyObjects {
                    let peripheral = getPeripheral(for: object.discoveryToken)
                    try dataCommunicationChannel.sendData(Data([UwbMessageId.stop.rawValue]), to: peripheral)
                    try dataCommunicationChannel.sendData(Data([UwbMessageId.initialize.rawValue]), to: peripheral)
                }
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
            if let token = session.discoveryToken {
                try dataCommunicationChannel.sendData(msg, to: getPeripheral(for: token))
            }
        } catch {
            print("Failed to stop connection when suspended")
        }
        
    }
    
    func sessionSuspensionEnded(_ session: NISession) {
        let msg = Data([UwbMessageId.initialize.rawValue])
        do {
            if let token = session.discoveryToken {
                try dataCommunicationChannel.sendData(msg, to: getPeripheral(for: token))
            }
        } catch {
            print("Failed to establish connection after suspension ended")
        }
    }
    
    private func getPeripheral(for key: NIDiscoveryToken) -> CBPeripheral? {
        if !configMap.keys.contains(key) {
            return nil
        }
        
        return configMap[key]
    }
}
