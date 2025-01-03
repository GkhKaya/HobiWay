//
//  AuthSignInView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import SwiftUI

struct AuthSignInView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var vm = AuthSignInViewViewModel()
    @State private var showForgotPasswordSheet: Bool = false


    @State private var isSignInSuccessful = false

    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.winterHaven.ignoresSafeArea()
                
                VStack{
                  
                    // MARK: - Welcome Description
                    
                    Text(LocalKeys.Auth.learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills.rawValue.locale())
                        .modifier(Px16Bold())
                        .padding(.top,ProjectPaddings.extraSmall.rawValue)
                    
                    // MARK: -  Text Fields
                    
                    VStack(){
                        TextFieldWidget(title:LocalKeys.General.email.rawValue.locale(),iconName: "envelope.fill", text: $vm.email)
                            .padding(.top,ProjectPaddings.extraSmall.rawValue)
                        
                      
                        
                        
                        SecureFieldWidget(iconName: "lock.fill", text: $vm.password)
                            .padding(.top,ProjectPaddings.extraSmall.rawValue)
                        
                        HStack {
                            Toggle(isOn: $vm.remember, label: {
                                Text("label")
                            }).toggleStyle(RememberStyle())
                            Spacer()
                            Button(action: {
                                showForgotPasswordSheet = true
                            }, label: {
                                Text(LocalKeys.Auth.forgotPassword.rawValue.locale()).bold().font(.footnote)
                                    .foregroundStyle(.safetyOrange)

                                    .modifier(Px16Bold())
                            }).tint(.primary)
                                .sheet(isPresented: $showForgotPasswordSheet) {
                                    ForgotPasswordView()
                                }
                        }.padding(.horizontal,ProjectPaddings.small.rawValue)
                        
                    }.padding(.top,ProjectPaddings.large.rawValue)
                    
                    
                    // MARK: - Sign In Button
                    Button{
                        Task{
                            
                                try await vm.signIn()
                                
                                try await vm.openInformationViewFunc()
                                
                            
                        }
                    }label:{
                        Text(LocalKeys.Auth.signIn.rawValue.locale())
                            .foregroundStyle(.white)
                            .modifier(Px16Bold())
                    }
                    
                    .padding()
                    .padding(.horizontal,ProjectPaddings.large.rawValue)
                    .background(.safetyOrange)
                    .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                    .padding(.top,ProjectPaddings.normal.rawValue)
                    .alert(isPresented: $vm.showAlert) {
                        Alert(title: Text("Sign In Error"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK")))
                    }
                    .navigationDestination(isPresented: $vm.openInformationView) {
                        InformationView().navigationBarBackButtonHidden()
                    }
                    
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
                                
                                Text(LocalKeys.Auth.signInWithApple.rawValue.locale())
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
                            Task{
                                try await vm.googleSignIn()
                                isSignInSuccessful = true
                            }
                        }label: {
                            
                            HStack{
                                
                                Image(ProjectImages.AuthImages.icGoogle.rawValue)
                                
                                Text(LocalKeys.Auth.signInWithGoogle.rawValue.locale())
                                    .foregroundStyle(.libertyBlue)
                                    .modifier(Px16Bold())
                                
                            } .padding()
                                .padding(.horizontal,ProjectRadius.extraLarge.rawValue)
                                .background(colorScheme == .light ? Color.white : Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                            
                        }
                        
                        .padding(.top,ProjectPaddings.extraSmall.rawValue)
                        Spacer()
                        
                        // MARK: - Sign In  Button
                        HStack(spacing: 0) {
                            Text(LocalKeys.Auth.ifYouDontHaveAnAccount.rawValue.locale())
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(.libertyBlue)
                            
                            Text(" ")
                            NavigationLink(destination: AuthSignUpView()) {
                                Text(LocalKeys.Auth.signUp.rawValue.locale())
                                    .font(.custom("Poppins-BoldItalic", size: 16))
                                    .foregroundColor(.libertyBlue)
                            }
                        }
                        
                    }.padding(.top,ProjectPaddings.large.rawValue)
                        .navigationBarBackButtonHidden(true) // Varsayılan geri butonunu gizle
                        .navigationBarItems(leading: CustomBackButton(presentationMode: _presentationMode))
                    
                    
                    Spacer()
                }.padding()
                    
                    .navigationDestination(isPresented: $vm.openhomeView) {
                        TabBarView().navigationBarBackButtonHidden()
                    }
            }
            .navigationTitle(LocalKeys.Auth.welcomeBack.rawValue.locale())
            .navigationBarBackButtonHidden(true)
         
        }
    }
    
    
}

#Preview {
    AuthSignInView()
}


    
