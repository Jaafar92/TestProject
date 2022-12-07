//
//  UwbMainView.swift
//  TestProject
//
//  Created by Jaafar on 07/12/2022.
//

import SwiftUI

struct UwbMainView: View {
    
    let viewModel: UwbMainViewModel
    
    init(viewModel: UwbMainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct UwbMainView_Previews: PreviewProvider {
    static var previews: some View {
        UwbMainView(viewModel: UwbMainViewModel())
    }
}
