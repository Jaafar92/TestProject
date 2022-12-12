//
//  BleProductItemView.swift
//  TestProject
//
//  Created by Jaafar on 09/12/2022.
//

import Foundation
import SwiftUI

struct BleProductItemView: View {
    var bleProduct: BleProduct

    var body: some View {
        Text("\(bleProduct.name)")
    }
}
