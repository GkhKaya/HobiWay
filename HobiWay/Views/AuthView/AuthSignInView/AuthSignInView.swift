//
//  AuthSignInView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import SwiftUI
import AuthenticationServices



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
                    
                    GeometryReader{ geometry in
                    VStack{
                        HStack{
                            Spacer()
                            // MARK: - Sign in Apple Button
                            Button{
                                Task{
                                    try await vm.signInApple()
                                    try await vm.openInformationViewFunc()
                                }
                            }label: {
                                SignInWithAppleButtonViewRepresentable(type: .default, style: colorScheme == .light ? .black : .white)
                                    .frame(width:geometry.dw(width: 0.4),height: geometry.dh(height: 0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                                    .padding()
                            }
                            
                            // MARK: - Sign in Google Button
                            
                            Button{
                                Task{
                                    try await vm.googleSignIn()
                                    try await vm.openInformationViewFunc()
                                    isSignInSuccessful = true
                                }
                            }label: {
                                
                                HStack{
                                    
                                    Image(ProjectImages.AuthImages.icGoogle.rawValue)
                                        .padding(.leading,6)
                                    
                                    Text(LocalKeys.Auth.signInWithGoogle.rawValue.locale())
                                        .multilineTextAlignment(.center)
                                        .foregroundStyle(.libertyBlue)
                                        .modifier(Px12Regular())
                                        
                                        
                                    
                                    
                                }
                                .frame(width:geometry.dw(width: 0.4),height: geometry.dh(height: 0.3))

                                    
                                    .background(colorScheme == .light ? Color.white : Color.black)
                                    .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                                
                            }
                                    
                            
                      
                            Spacer()

                            
                        }
                        
                        
                        
                        // MARK: - Sign In  Button
                        HStack(spacing: 0) {
                            Text(LocalKeys.Auth.ifYouDontHaveAnAccount.rawValue.locale())
                                .foregroundColor(.libertyBlue)
                                .modifier(Px12Regular())
                            
                            Text(" ")
                            NavigationLink(destination: AuthSignUpView()) {
                                Text(LocalKeys.Auth.signUp.rawValue.locale())
                                    .foregroundColor(.libertyBlue)
                                    .modifier(Px12Bold())
                            }
                        }
                        
                    }.padding(.top,ProjectPaddings.large.rawValue)
                        .navigationBarBackButtonHidden(true) 
                        .navigationBarItems(leading: CustomBackButton(presentationMode: _presentationMode))
                }
                    
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


    
