//
//  GreenView.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import SwiftUI

struct GreenView: View {
    
    let viewModel: GreenViewModel
    
    init(viewModel: GreenViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            VStack {
                Text("Green View")
                
                Button(action: {
                    viewModel.navigateToYellowView()
                }, label: {
                    Text("Navigate to yellow")
                })
            }
        }
    }
}

struct GreenView_Previews: PreviewProvider {
    static var previews: some View {
        GreenView(viewModel: GreenViewModel())
    }
}
