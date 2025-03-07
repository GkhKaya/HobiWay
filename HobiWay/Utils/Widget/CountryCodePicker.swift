//
//  CountryCodePicker.swift
//  HobiWay
//
//  Created by Gökhan Kaya on 6.03.2025.
//

import Foundation
import SwiftUI
struct CountryCodePicker: View {
    @Binding var selectedCountryCode: CountryCode
    @State private var searchText: String = ""
    let countries: [CountryCode]
    @Environment(\.dismiss) var dismiss // Dismiss environment variable to close the sheet
    
    var filteredCountries: [CountryCode] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.dial_code.contains(searchText) ||
                $0.code.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCountries) { country in
                    Button(action: {
                        selectedCountryCode = country
                        dismiss() // Automatically close the sheet after selection
                    }) {
                        HStack {
                            Text(country.dial_code)
                            Text(country.name)
                            Spacer()
                            Text(country.code)
                        }
                    }
                }
            }
            .navigationTitle(LocalKeys.InformationView.selectCountryCode.rawValue.locale())
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
