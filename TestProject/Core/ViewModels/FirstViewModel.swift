//
//  FirstViewViewModel.swift
//  TestProject
//
//  Created by Jaafar on 29/07/2021.
//

import Combine

class FirstViewModel : BaseViewModel {
    @Published var text: String = ""
    
    func changeText() async throws {
        self.text = "Hello World"
        let repository = MitElRepository()
        
        do {
           try await repository.getSpotPricesForPeriod()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func navigateToSecondView() {
        (coordinator as? MainCoordinator)?.navigateToSecondView()
    }
}
