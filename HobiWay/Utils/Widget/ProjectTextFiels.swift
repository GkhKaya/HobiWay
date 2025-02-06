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
                Text(title)
                    .foregroundColor(.winterHaven)
                    .modifier(Px16Regular())
                    .opacity(isFocused || isFieldFocused || !text.isEmpty ? 0 : 1)
                    .animation(.easeInOut(duration: 0.3), value: isFocused || isFieldFocused || !text.isEmpty)
                
                TextField("", text: $text)
                    .foregroundColor(.winterHaven)
                    .focused($isFieldFocused)
                    .onTapGesture {
                        withAnimation {
                            isFocused = true
                        }
                    }
                    .onChange(of: text, perform: { newValue in
                        withAnimation {
                            isFocused = !newValue.isEmpty
                        }
                    })
            }
        }
        .padding()
        .background(.libertyBlue)
        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
    }
}

struct TextFieldWidget: View {
    var title: LocalizedStringKey
    var iconName: String
    @Binding var text: String
    @State private var isFocused: Bool = false
    @FocusState private var isFieldFocused: Bool
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: iconName)
                .foregroundStyle(.winterHaven)
            
            ZStack(alignment: .leading) {
                Text(title)
                    .foregroundColor(.winterHaven)
                    .modifier(Px16Regular())
                    .opacity(isFocused || isFieldFocused || !text.isEmpty ? 0 : 1)
                    .animation(.easeInOut(duration: 0.3), value: isFocused || isFieldFocused || !text.isEmpty)
                
                TextField("", text: $text)
                    .foregroundColor(.winterHaven)
                    .focused($isFieldFocused)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .onTapGesture {
                        withAnimation {
                            isFocused = true
                        }
                    }
                    .onChange(of: text, perform: { newValue in
                        withAnimation {
                            isFocused = !newValue.isEmpty
                        }
                    })
            }
        }
        .padding()
        .background(.libertyBlue)
        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
    }
}

struct SecureFieldWidget: View {
    var iconName: String
    @Binding var text: String
    @State private var isFocused: Bool = false
    @FocusState private var isFieldFocused: Bool
    @State private var isPasswordVisible: Bool = false
    var placeHolderText: LocalizedStringKey?
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundStyle(.winterHaven)
            
            ZStack(alignment: .leading) {
                Text(placeHolderText ?? LocalKeys.General.password.rawValue.locale())
                    .foregroundColor(.winterHaven)
                    .modifier(Px16Regular())
                    .opacity(isFocused || isFieldFocused || !text.isEmpty ? 0 : 1)
                    .animation(.easeInOut(duration: 0.3), value: isFocused || isFieldFocused || !text.isEmpty)
                
                if isPasswordVisible {
                    TextField("", text: $text)
                        .foregroundColor(.winterHaven)
                        .focused($isFieldFocused)
                        .textInputAutocapitalization(.never)
                        .onTapGesture {
                            withAnimation {
                                isFocused = true
                            }
                        }
                        .onChange(of: text, perform: { newValue in
                            withAnimation {
                                isFocused = !newValue.isEmpty
                            }
                        })
                } else {
                    SecureField("", text: $text)
                        .foregroundColor(.winterHaven)
                        .focused($isFieldFocused)
                        .onTapGesture {
                            withAnimation {
                                isFocused = true
                            }
                        }
                        .onChange(of: text, perform: { newValue in
                            withAnimation {
                                isFocused = !newValue.isEmpty
                            }
                        })
                }
            }
            
            Button(action: {
                isPasswordVisible.toggle()
            }) {
                Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                    .foregroundColor(.winterHaven)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.trailing, 10)
        }
        .padding()
        .background(.libertyBlue)
        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
    }
}
