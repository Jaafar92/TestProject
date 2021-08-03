//
//  YellowView.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import SwiftUI

struct YellowView: View {
    
    let viewModel: YellowViewModel
    
    init(viewModel: YellowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.yellow.ignoresSafeArea()
            
            VStack {
                Text("Yellow View")
                
                Button(action: {
                    viewModel.navigateToRoot()
                }, label: {
                    Text("Navigate to root")
                })
                
                Button(action: {
                    viewModel.navigateToBananaView()
                }, label: {
                    Text("Navigate Banana View")
                })
            }
        }
    }
}

struct YellowView_Previews: PreviewProvider {
    static var previews: some View {
        YellowView(viewModel: YellowViewModel())
    }
}
