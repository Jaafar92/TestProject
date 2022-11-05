//
//  FifthView.swift
//  TestProject
//
//  Created by Jaafar on 01/08/2021.
//

import SwiftUI

struct FifthView: View {
    
    let viewModel: FifthViewModel
    
    init(viewModel: FifthViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("FifthView: This is the end")
            }
            .navigationBarTitle(Text("Fifth View"), displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    viewModel.dissmiss()
                })
            {
                Text("Done").bold()
            })
        }
    }
}

struct FifthView_Previews: PreviewProvider {
    static var previews: some View {
        FifthView(viewModel: FifthViewModel())
    }
}
