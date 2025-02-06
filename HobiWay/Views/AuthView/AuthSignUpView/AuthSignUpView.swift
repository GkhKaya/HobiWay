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
    @State private var navigateToSignIn: Bool = false // Navigate state

    
    
    
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
                        
                    }.padding(.top,ProjectPaddings.large.rawValue)
                    
                    
                    // MARK: - Sign Up Button
                    Button{
                        Task{
                                try await vm.signUp()
            
                        }
                    }label:{
                        Text(LocalKeys.Auth.signUp.rawValue.locale())
                            .foregroundStyle(.white)
                            .modifier(Px16Bold())
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
                    
                    
                    GeometryReader {geometry in
                        VStack{
                            HStack{
                                Spacer()

                                // MARK: - Sign in Apple Button
                                Button{
                                    Task{
                                        try await vm.signUpApple()
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
                                        try await vm.signUpGoogle()
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
                            
                            .padding(.top,ProjectPaddings.extraSmall.rawValue)
                            Spacer()
                            
                            // MARK: - Sign In  Button
                            HStack(spacing: 0) {
                                Text(LocalKeys.Auth.ifYouHaveAnAccount.rawValue.locale())
                                    .foregroundColor(.libertyBlue)
                                    .modifier(Px12Regular())
                                
                                Text(" ")
                                NavigationLink(destination: AuthSignUpView()) {
                                    Text(LocalKeys.Auth.signIn.rawValue.locale())
                                        .foregroundColor(.libertyBlue)
                                        .modifier(Px12Bold())
                                }
                            }
                            
                        }.padding(.top,ProjectPaddings.large.rawValue)
                            .navigationBarBackButtonHidden(true) // Varsayılan geri butonunu gizle
                            .navigationBarItems(leading: CustomBackButton(presentationMode: _presentationMode))
                    }
                    
                    
                    Spacer()
                }.padding()
            }.navigationTitle(LocalKeys.Auth.joinUs.rawValue.locale())
                .alert(isPresented: $vm.showAlert) { // Alert gösterme
                Alert(title: Text(LocalKeys.Auth.signUp.rawValue.locale()),
                      message: Text(vm.errorMessage),
                      dismissButton: .default(Text(LocalKeys.General.okay.rawValue.locale())) {
                                              navigateToSignIn = true // Set navigation to true when alert is dismissed
                                          })
                }
            
                .alert(isPresented: $vm.showSuccessAlert) {
                    Alert(
                        title: Text(LocalKeys.General.success.rawValue.locale()),
                        message: Text(LocalKeys.Auth.accountCreatedSuccessful.rawValue.locale()),
                        dismissButton: .default(Text(LocalKeys.General.okay.rawValue.locale())) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
  

#Preview {
    AuthSignUpView()
}






