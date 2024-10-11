//
//  AuthSignUpView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 7.10.2024.
//

import SwiftUI

struct AuthSignUpView: View {
    @ObservedObject private var vm = AuthSignUpViewViewModel()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.winterHaven.ignoresSafeArea()
                
                VStack{
                    // MARK: - Welcome Text
                    HStack {
                        Text(LocalKeys.Auth.joinUs.rawValue.locale())
                            .modifier(Px32Bold())
                        Spacer()
                    }
                    // MARK: - Welcome Description
                    
                    Text(LocalKeys.Auth.learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills.rawValue.locale())
                        .modifier(Px16Bold())
                        .padding(.top,ProjectPaddings.extraSmall.rawValue)
                    
                    // MARK: -  Text Fields
                    
                    VStack(){
                        
                        TextFieldWidget(title:LocalKeys.General.fullName.rawValue.locale(),iconName: "person.fill", text: $vm.userName)
                            .padding(.top,ProjectPaddings.extraSmall .rawValue)
                        TextFieldWidget(title:LocalKeys.General.email.rawValue.locale(),iconName: "envelope.fill", text: $vm.email)
                            .padding(.top,ProjectPaddings.extraSmall.rawValue)
                        
                        
                        SecureFieldWidget(iconName: "lock.fill", text: $vm.password)
                            .padding(.top,ProjectPaddings.extraSmall.rawValue)
                        
                    }.padding(.top,ProjectPaddings.large.rawValue)
                    
                    
                    // MARK: - Sign Up Button
                    Button{
                        Task{
                            do {
                                try await vm.signUp()
                                alertMessage = "Successfully signed up!"
                            } catch {
                                alertMessage = (error as? AuthError)?.localizedDescription ?? "An unknown error occurred."
                            }
                            showAlert = true
                        }
                    }label:{
                        Text(LocalKeys.Auth.signUp.rawValue.locale())
                            .foregroundStyle(.winterHaven)
                    }
                    .padding()
                    .padding(.horizontal,ProjectPaddings.large.rawValue)
                    .background(.safetyOrange)
                    .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                    .padding(.top,ProjectPaddings.normal.rawValue)
                    
                    // MARK: - or Text
                    
                    HStack{
                        VStack {
                            Divider()
                        }
                        Text("or")
                        VStack {
                            Divider()
                        }
                        
                    }.padding(.top,ProjectPaddings.normal.rawValue)
                    
                    // MARK: - Sign Up Apple Button
                    
                    VStack{
                        Button{
                            
                        }label: {
                            HStack{
                                Image(ProjectImages.AuthImages.icApple.rawValue)
                                
                                Text(LocalKeys.Auth.signUpWithApple.rawValue.locale())
                                    .foregroundStyle(.winterHaven)
                                    .modifier(Px16Bold())
                            }
                        }
                        .padding()
                        .padding(.horizontal,ProjectRadius.extraLarge.rawValue)
                        .background(.libertyBlue)
                        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                        
                        // MARK: - Sign Up Google Button
                        
                        Button{
                            
                        }label: {
                            
                            HStack{
                                
                                Image(ProjectImages.AuthImages.icGoogle.rawValue)
                                
                                Text(LocalKeys.Auth.signUpWithGoogle.rawValue.locale())
                                    .foregroundStyle(.libertyBlue)
                                    .modifier(Px16Bold())
                                
                            } .padding()
                                .padding(.horizontal,ProjectRadius.extraLarge.rawValue)
                                .background(colorScheme == .light ? Color.white : Color.black)                         .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                            
                        }
                        
                        .padding(.top,ProjectPaddings.extraSmall.rawValue)
                        Spacer()
                        
                        // MARK: - Sign In  Button
                        HStack(spacing: 0) {
                            Text(LocalKeys.Auth.ifYouHaveAnAccount.rawValue.locale())
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(.libertyBlue)
                            
                            Text(" ")
                            NavigationLink(destination: AuthSignInView()) {
                                Text(LocalKeys.Auth.signIn.rawValue.locale())
                                    .font(.custom("Poppins-BoldItalic", size: 16))
                                    .foregroundColor(.libertyBlue)
                            }
                        }
                        
                    }.padding(.top,ProjectPaddings.large.rawValue)
                        .navigationBarBackButtonHidden(true) // Varsayılan geri butonunu gizle
                        .navigationBarItems(leading: CustomBackButton(presentationMode: _presentationMode))
                    
                    
                    Spacer()
                }.padding()
            }
            .alert(isPresented: $showAlert) { // Alert gösterme
                Alert(title: Text("Sign Up"),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AuthSignUpView()
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
    
    var body: some View {
        HStack() {
            Image(systemName: iconName)
                .foregroundStyle(.winterHaven)
            
            ZStack(alignment: .leading) {
                // Placeholder metni
                Text(LocalKeys.General.password.rawValue.locale()) // Placeholder metni buraya ekleyin
                    .foregroundColor(.winterHaven)
                    .modifier(Px16Regular())
                    .opacity(isFocused || isFieldFocused || !text.isEmpty ? 0 : 1) // Opacity animasyonu
                    .animation(.easeInOut(duration: 0.3), value: isFocused || isFieldFocused || !text.isEmpty)
                
                // SecureField veya TextField
                if isPasswordVisible {
                    TextField("", text: $text) // Eğer şifre görünürse TextField kullan
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


struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Button{
            if presentationMode.wrappedValue.isPresented{
                presentationMode.wrappedValue.dismiss()
            }
        }label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.libertyBlue)
        }
        
        
    }
}


