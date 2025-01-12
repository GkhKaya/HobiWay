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
            }.navigationTitle(LocalKeys.Auth.joinUs.rawValue.locale())
                .alert(isPresented: $vm.showAlert) { // Alert gösterme
                Alert(title: Text(LocalKeys.Auth.signUp.rawValue.locale()),
                      message: Text(vm.errorMessage),
                      dismissButton: .default(Text(LocalKeys.General.okay.rawValue.locale())) {
                                              navigateToSignIn = true // Set navigation to true when alert is dismissed
                                          })
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
  

#Preview {
    AuthSignUpView()
}






