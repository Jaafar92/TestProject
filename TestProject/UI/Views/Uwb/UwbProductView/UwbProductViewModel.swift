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
    var bleManager: BleManager?
    var uwbManager: UwbManager?
    var product: BleProduct?
    
    @Published var connectionState: String?
    @Published var distance: String = "Distance is: unknown"
    @Published var uwbConnectionStatus: String = "UWB Connected: false"
    
    func setupHandlers() {
        connectionState = product?.peripheral.state == .connected ? "Connected" : "Not connected"
        bleManager?.accessoryDidConnectHandler = accessoryDidConnectHandler
        bleManager?.accessoryDidDisconnectHandler = accessoryDidDisconnectHandler
        bleManager?.accessoryDataHandler = accessoryDataHandler
        
        if let bleManager = bleManager {
            uwbManager = UwbManager.shared
            uwbManager?.setupBleManager(manager: bleManager)
        }
        
        uwbManager?.accessoryDidUpdateDistanceHandler = accessoryDistanceHandler
        uwbConnectionStatus = "UWB Connected: \(uwbManager?.isUwbConnected(to: product?.peripheral) ?? false)"
        updateDistanceText(for: product?.peripheral)
    }
    
    func startUwbManager() {
        uwbManager?.initUwbConnection(for: product?.peripheral)
    }
    
    func connect() {
        if let product = product {
            bleManager?.connect(peripheral: product.peripheral)
        }
    }
    
    func disconnect() {
        if let product = product {
            bleManager?.disconnect(peripheral: product.peripheral)
        }
    }
    
    func accessoryDataHandler(_ data: Data, _ peripheral: CBPeripheral) {
        guard let uuid = product?.peripheral.identifier else { return }
        
        if uuid == peripheral.identifier {
            uwbManager?.accessorySharedData(data: data, to: peripheral)
        }
    }
    
    func accessoryDistanceHandler(distance: Float, to peripheral: CBPeripheral) {
        guard let uuid = product?.peripheral.identifier else { return }
        
        if uuid == peripheral.identifier {
            self.distance = String(format: "Distance is %0.1f meters away", distance)
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
    
    private func updateDistanceText(for peripheral: CBPeripheral?) {
        let distance = uwbManager?.getDistance(to: peripheral)
        
        if let distance = distance {
            self.distance = String(format: "Distance is %0.1f meters away", distance)
        }
    }
}
