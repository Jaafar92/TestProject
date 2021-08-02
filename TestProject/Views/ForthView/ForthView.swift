//
//  ForthView.swift
//  TestProject
//
//  Created by Jaafar on 31/07/2021.
//

import SwiftUI

protocol ForthViewCoordinatorDelegate {
    func navigateToThirdView()
    func navigateOneBack()
    func navigateToRootNoHistory()
    func navigateToThirdAndClearHistory()
    func navigateToFifthView()
}

struct ForthView: View {
    
    @ObservedObject var viewModel: ForthViewModel
    
    init(viewModel: ForthViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.text)
            
            Spacer()
            
            Button(action: {
                viewModel.changeText()
            }, label: {
                Text("Change text")
            })
            
            Button(action: {
                viewModel.navigateToThirdView()
            }, label: {
                Text("Navigate to third view")
            })
    
            
            Button(action: {
                viewModel.navigateOneBack()
            }, label: {
                Text("Navigate to one back")
            })
            
            
            Button(action: {
                viewModel.navigateToRootNoHistory()
            }, label: {
                Text("Navigate to back no history")
            })
            
            Button(action: {
                viewModel.navigateToThirdAndClearHistory()
            }, label: {
                Text("Navigate to Third and clear history")
            })
            
            Button(action: {
                viewModel.navigateToFifthView()
            }, label: {
                Text("Navigate to Fifth View")
            })
            
        }
    }
}

struct ForthView_Previews: PreviewProvider {
    static var previews: some View {
        ForthView(viewModel: ForthViewModel())
    }
}
