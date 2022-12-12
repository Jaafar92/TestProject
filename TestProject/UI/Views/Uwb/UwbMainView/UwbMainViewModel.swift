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
    
    var dataCommunicationChannel: DataCommunicationChannel
    
    override init() {
        dataCommunicationChannel = DataCommunicationChannel()
        
        super.init()
        dataCommunicationChannel.accessoryUpdatedWithNewPeripheral = self.accessoryUpdatedWithNewPeripheral
        dataCommunicationChannel.start()
        
    }
    
    func startScanning() {
        dataCommunicationChannel.startScanning()
    }
    
    func stopScanning() {
        dataCommunicationChannel.stopScanning()
    }
    
    func navigateToProductPage(product: BleProduct) {
        (coordinator as? UwbCoordinator)?.navigateToProductPage(product: product, communicationChannel: dataCommunicationChannel)
    }
    
    func connect(toProduct product: BleProduct) {
        dataCommunicationChannel.connect(peripheral: product.peripheral)
    }
    
    private func accessoryUpdatedWithNewPeripheral(bleProducts: [BleProduct]) {
        peripherals = bleProducts
    }
}
