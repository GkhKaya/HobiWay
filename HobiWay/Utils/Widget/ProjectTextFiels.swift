//
//  ProjectTextFiels.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 22.10.2024.
//

import Foundation
import SwiftUI


struct PhoneNumberTextField: View {
    var title: LocalizedStringKey
    @Binding var text: String
    @Binding var selectedCountryCode: CountryCode
    @State private var isFocused: Bool = false
    @State private var showCountryCodePicker = false
    @FocusState private var isFieldFocused: Bool
    @ObservedObject var fetcher = FetchCountryCode()
    
    var body: some View {
        HStack(alignment: .center) {
            // Ülke kodu seçmek için bir buton
            Button(action: {
                showCountryCodePicker.toggle()
            }) {
                HStack {
                    Text("\(selectedCountryCode.dial_code) \(selectedCountryCode.code)")
                        .foregroundColor(.winterHaven)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .sheet(isPresented: $showCountryCodePicker) {
                CountryCodePicker(selectedCountryCode: $selectedCountryCode, countries: fetcher.countries)
            }
            
            ZStack(alignment: .leading) {
                // Placeholder metni
                Text(title)
                    .foregroundColor(.winterHaven)
                    .modifier(Px16Regular())
                    .opacity(isFocused || isFieldFocused || !text.isEmpty ? 0 : 1) // Opacity animasyonu
                    .animation(.easeInOut(duration: 0.3), value: isFocused || isFieldFocused || !text.isEmpty)
                
                // TextField
                TextField("", text: $text)
                    .foregroundColor(.winterHaven)
                    .focused($isFieldFocused)
                    .onTapGesture {
                        withAnimation {
                            isFocused = true
                        }
                    }
                    .onChange(of: text) { oldValue, newValue in
                        // TextField içeriği değiştiğinde odaklanma durumunu güncelle
                        withAnimation {
                            isFocused = !newValue.isEmpty
                        }
                    }
            }
        }
        .padding()
        .background(.libertyBlue)
        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
    }
}
