//
//  MitElRepository.swift
//  TestProject
//
//  Created by Jaafar on 04/11/2022.
//

import Foundation

class MitElRepository {
    let baseUrl = "https://dev-mitel.jaafardevelopment.com"
    
    func getSpotPricesForPeriod() async throws {
//        let startDate = 1664668800000
//        let endDate = 1664755200000
//        let region = "DK2"
        
        let url = URL(string: "\(baseUrl)/api/v1/SpotPrice/getSpotPriceForPeriod?startDate=1664668800000&endDate=1664755200000&areaCode=DK2")
        guard let url = url else { return }
        
        let request = URLRequest(url: url)
        let (_, response) = try await URLSession.shared.data(for: request)
        
        let resp = response as? HTTPURLResponse
        print("Response code is: \(resp?.statusCode ?? 0)")
    }
}
