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
    @Published var product: BleProduct?
    @Published var connectionState: String?
    
    func setupHandlers() {
        connectionState = product?.peripheral.state == .connected ? "Connected" : "Not connected"
        dataCommunicationChannel?.accessoryDidConnectHandler = accessoryDidConnectHandler
        dataCommunicationChannel?.accessoryDidDisconnectHandler = accessoryDidDisconnectHandler
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
