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


struct TextFieldWidget: View {
    var title : LocalizedStringKey
    var iconName: String
    @Binding var text : String
    @State private var isFocused: Bool = false
    @FocusState private var isFieldFocused: Bool
    var body: some View {
        HStack(alignment: .center){
            Image(systemName: iconName)
                .foregroundStyle(.winterHaven)
            
            
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
                    .textInputAutocapitalization(.never)
                    .onTapGesture {
                        withAnimation {
                            isFocused = true
                        }
                    }
                    .onChange(of: text) { oldValue, newValue in
                        // Email değiştiğinde odaklanma durumunu güncelle
                        withAnimation {
                            isFocused = !newValue.isEmpty
                        }
                    }
                
                    .onChange(of: isFocused) { oldValue, newValue in
                        // Focus durumu değiştiğinde animasyonu uygula
                        withAnimation {
                            // Gerekirse ek işlemler
                        }
                    }
                
            }
            
        }.padding()
            .background(.libertyBlue)
            .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
    }
}

struct SecureFieldWidget: View {
    var iconName: String
    @Binding var text: String
    @State private var isFocused: Bool = false
    @FocusState private var isFieldFocused: Bool
    @State private var isPasswordVisible: Bool = false // Şifre görünürlüğü durumu
    var placeHolderText: LocalizedStringKey?
    
    var body: some View {
        HStack() {
            Image(systemName: iconName)
                .foregroundStyle(.winterHaven)
            
            ZStack(alignment: .leading) {
                // Placeholder metni
                Text(placeHolderText ?? LocalKeys.General.password.rawValue.locale() )
                    .foregroundColor(.winterHaven)
                    .modifier(Px16Regular())
                    .opacity(isFocused || isFieldFocused || !text.isEmpty ? 0 : 1) // Opacity animasyonu
                    .animation(.easeInOut(duration: 0.3), value: isFocused || isFieldFocused || !text.isEmpty)
                
                // SecureField veya TextField
                if isPasswordVisible {
                    TextField("", text: $text)
                    // Eğer şifre görünürse TextField kullan
                        .foregroundColor(.winterHaven)
                        .focused($isFieldFocused) // Odağı ayarlamak için kullanılıyor
                        .textInputAutocapitalization(.never)

                        .onTapGesture {
                            withAnimation {
                                isFocused = true
                            }
                        }
                        .onChange(of: text) { oldValue, newValue in
                            withAnimation {
                                isFocused = !newValue.isEmpty
                            }
                        }
                } else {
                    SecureField("", text: $text) // Eğer şifre gizliyse SecureField kullan
                        .foregroundColor(.winterHaven)
                        .focused($isFieldFocused) // Odağı ayarlamak için kullanılıyor
                        .onTapGesture {
                            withAnimation {
                                isFocused = true
                            }
                        }
                        .onChange(of: text) { oldValue, newValue in
                            withAnimation {
                                isFocused = !newValue.isEmpty
                            }
                        }
                }
                
                // Göz simgesi
                
            }
            Button(action: {
                isPasswordVisible.toggle() // Şifre görünürlüğünü değiştir
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill") // Göz simgesi
                    .foregroundColor(.winterHaven)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 10) // Göz simgesinin sağa biraz mesafe koy
        }
        .padding()
        .background(.libertyBlue)
        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
    }
}
