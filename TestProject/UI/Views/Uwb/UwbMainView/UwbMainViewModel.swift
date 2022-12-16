//
//  UwbMainViewModel.swift
//  TestProject
//
//  Created by Jaafar on 07/12/2022.
//

import Foundation
import NearbyInteraction
import CoordinatorNavigation
import SwiftUI

class UwbMainViewModel : BaseViewModel, ObservableObject {
    @Published var peripherals: [BleProduct] = []
    var pageTitle = "Peripherals"
    
    var bleManager: BleManager
    
    override init() {
        bleManager = BleManager.shared
        
        super.init()
        bleManager.accessoryUpdatedWithNewPeripheral = self.accessoryUpdatedWithNewPeripheral
        bleManager.start()
        
    }
    
    func startScanning() {
        bleManager.startScanning()
    }
    
    func stopScanning() {
        bleManager.stopScanning()
    }
    
    func navigateToProductPage(product: BleProduct) {
        (coordinator as? UwbCoordinator)?.navigateToProductPage(product: product, communicationChannel: bleManager)
    }
    
    func connect(toProduct product: BleProduct) {
        bleManager.connect(peripheral: product.peripheral)
    }
    
    private func accessoryUpdatedWithNewPeripheral(bleProducts: [BleProduct]) {
        peripherals = bleProducts
    }
}
