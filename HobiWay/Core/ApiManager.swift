//
//  ApiManager.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 22.10.2024.
//

import Foundation



class FetchCountryCode: ObservableObject {
    @Published var countries: [CountryCode] = []
    
    init() {
        fetchCountryCode()
    }
    
    func fetchCountryCode() {
        if let url = Bundle.main.url(forResource: "CountryCodes", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([CountryCode].self, from: data) {
                countries = decoded
            }
        }
    }
}
