//
//  BananaView.swift
//  TestProject
//
//  Created by Jaafar on 03/08/2021.
//

import SwiftUI

struct BananaView: View {
    
    let viewModel: BananaViewModel
    
    init(viewModel: BananaViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("Banana View")
            Button(action: {
                viewModel.navigateToRoot()
            }, label: {
                Text("Navigate to root")
            })
        }
    }
}

struct BananaView_Previews: PreviewProvider {
    static var previews: some View {
        BananaView(viewModel: BananaViewModel())
    }
}
