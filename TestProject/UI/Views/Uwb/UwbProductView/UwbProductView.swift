//
//  UwbProductView.swift
//  TestProject
//
//  Created by Jaafar on 12/12/2022.
//

import SwiftUI

struct UwbProductView: View {
    @ObservedObject var viewModel: UwbProductViewModel
    
    init(viewModel: UwbProductViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("BLE Connection state: \(viewModel.connectionState ?? "Unknown")")
                
                HStack {
                    Spacer()
                    
                    Button("Connect", action: viewModel.connect)
                    
                    Spacer()
                    
                    Button("Disconnect", action: viewModel.disconnect)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .navigationTitle(viewModel.product?.name ?? "Unknown Product")
        }
    }
}

//struct UwbProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        UwbProductView()
//    }
//}
