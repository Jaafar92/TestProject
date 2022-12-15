//
//  UwbProductViewModel.swift
//  TestProject
//
//  Created by Jaafar on 12/12/2022.
//

import Foundation
import CoordinatorNavigation
import CoreBluetooth
import SwiftUI

class UwbProductViewModel : BaseViewModel, ObservableObject {
    var dataCommunicationChannel: DataCommunicationChannel?
    var uwbManager: UwbManager?
    var product: BleProduct?
    
    @Published var connectionState: String?
    @Published var distance: String?
    
    func setupHandlers() {
        connectionState = product?.peripheral.state == .connected ? "Connected" : "Not connected"
        dataCommunicationChannel?.accessoryDidConnectHandler = accessoryDidConnectHandler
        dataCommunicationChannel?.accessoryDidDisconnectHandler = accessoryDidDisconnectHandler
        dataCommunicationChannel?.accessoryDataHandler = accessoryDataHandler
        
        if let dataCommunicationChannel = dataCommunicationChannel {
            uwbManager = UwbManager(dataCommunicationChannel: dataCommunicationChannel)
        }
        
        uwbManager?.accessoryDidUpdateDistanceHandler = accessoryDistanceHandler
    }
    
    func startUwbManager() {
        uwbManager?.initUwbConnection(for: product?.peripheral)
    }
    
    func connect() {
        if let product = product {
            dataCommunicationChannel?.connect(peripheral: product.peripheral)
        }
    }
    
    func disconnect() {
        if let product = product {
            dataCommunicationChannel?.disconnect(peripheral: product.peripheral)
        }
    }
    
    func accessoryDataHandler(_ data: Data, _ peripheral: CBPeripheral) {
        uwbManager?.accessorySharedData(data: data, to: peripheral)
    }
    
    func accessoryDistanceHandler(distance: Float) {
        self.distance = String(format: "Distance is %0.1f meters away", distance)
    }
    
    func accessoryDidConnectHandler(peripheral: CBPeripheral) {
        guard let uuid = product?.peripheral.identifier else { return }
        
        if uuid == peripheral.identifier {
            product?.peripheral = peripheral
            connectionState = "Connected"
        }
    }
    
    func accessoryDidDisconnectHandler(peripheral: CBPeripheral) {
        guard let uuid = product?.peripheral.identifier else { return }
        
        if uuid == peripheral.identifier {
            product?.peripheral = peripheral
            connectionState = "Not connected"
        }
    }
}
