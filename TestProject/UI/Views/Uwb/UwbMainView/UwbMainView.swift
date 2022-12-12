//
//  UwbMainView.swift
//  TestProject
//
//  Created by Jaafar on 07/12/2022.
//

import SwiftUI

struct UwbMainView: View {
    
    @ObservedObject var viewModel: UwbMainViewModel
    
    init(viewModel: UwbMainViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    
                    Button("Scan", action: viewModel.startScanning)

                    Spacer()
                    
                    Button("Stop scanning", action: viewModel.stopScanning)
                    
                    Spacer()
                }
                
                List(viewModel.peripherals) { product in
                    Button(action: {
                        viewModel.navigateToProductPage(product: product)
                    }) {
                        BleProductItemView(bleProduct: product)
                    }
                }
            }
            .navigationTitle(viewModel.pageTitle)
        }
    }
}

//struct UwbMainView_Previews: PreviewProvider {
//    var vm = UwbMainViewModel()
//
//    static var previews: some View {
//        vm.peripherals = [BleProduct(name: "Beosound A5")]
//        UwbMainView(viewModel: vm)
//    }
//}
