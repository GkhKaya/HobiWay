//
//  AuthSignInViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import Foundation
import SwiftUI

@MainActor
final class AuthSignInViewViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var remember: Bool = false
    @Published private var isFirstLaunch = false
    @Published var openInformationView = false
    @Published var openhomeView = false
    @Published  var isSignInSuccessful = false
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var showAlert: Bool = false


    
    
    
    
    
    func signIn() async throws{
        guard ValidationHelper.isNonEmpty(email),ValidationHelper.isNonEmpty(password) else{
            await MainActor.run {
                self.errorMessage = LocalKeys.AuthErrorCode.authFieldsEmpty.rawValue.locale()
                self.showAlert = true
            }
            throw AuthError.invalidEmail
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            await MainActor.run {
                self.errorMessage = LocalKeys.AuthErrorCode.invalidMail.rawValue.locale()
                self.showAlert = true
            }
          
            
            throw AuthError.invalidEmail
        }
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            do{
                _ = try await authManager.signIn(email: email, password: password)
                
                if remember{
                    UserDefaults.standard.set(true, forKey: "isRemembered")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                }
                
            }catch{
                Task { @MainActor in
                    self.errorMessage = LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
                    self.showAlert = true
                }
                throw AuthError.userNotFound
            }
        }
    }
    
    
    
    func googleSignIn() async throws {
        
        do{
            let helper  = SignInGoogleHelper()
            let token = try await helper.signIn()
            
            if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
                _ = try await authManager.signInWithGoogle(tokens: token)
            }
        }catch{
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.signInFailed.rawValue.locale()
                self.showAlert = true
            }
            throw AuthError.signInFailed
        }
    }
    
    func signInApple() async throws {
        do{
            let helper = SignInAppleHelper()
            let tokens = try await helper.startSignInWithAppleFlow()
       
            if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
                _ = try await authManager.signInWithApple(tokens: tokens)
            }
        }catch{
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.signInFailed.rawValue.locale()
                self.showAlert = true
            }
        }
}
    
    
    
    func openInformationViewFunc() async throws {
        
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            let userId = try  authManager.getAuthenticatedUser().uid
            
            if let firestoreService : FirestoreService = ServiceLocator.shared.getService(){
                
                if let userData : UserModel = try await firestoreService.getDocumentWhere(from: "users", where: [(field: "id", value: userId)]){
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                       if userData.age == 0 {
                                           self.openInformationView = true
                                       } else {
                                           self.openhomeView = true
                                       }
                                   }
                   
                }
                
            }
        }
        
    }
    
    
}


