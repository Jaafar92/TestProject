//
//  BleProduct.swift
//  TestProject
//
//  Created by Jaafar on 09/12/2022.
//

import Foundation
import CoreBluetooth
import SwiftUI

class BleProduct: Identifiable, ObservableObject {
    var id = UUID()
    
    var name: String
    var peripheral: CBPeripheral
    var bleUuid: UUID
    
    init(with peripheral: CBPeripheral) {
        name = peripheral.name ?? "Unknown"
        self.peripheral = peripheral
        bleUuid = peripheral.identifier
    }
}
