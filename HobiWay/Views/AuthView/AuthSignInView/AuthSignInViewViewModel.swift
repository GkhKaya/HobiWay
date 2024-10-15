//
//  AuthSignInViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import Foundation

final class AuthSignInViewViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var remember: Bool = false

    
    
    func signIn() async throws{
        guard ValidationHelper.isNonEmpty(email),ValidationHelper.isNonEmpty(password) else{
            throw AuthError.custom(message: "Email or Password is empty")
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            throw AuthError.custom(message: "Email is not valid form.")
        }
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            do{
                _ = try await authManager.signIn(email: email, password: password)
                
                if remember{
                    UserDefaults.standard.set(true, forKey: "isRemembered")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                }
                
            }catch{
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
            throw AuthError.signInFailed
        }
        
        
        
    }
}
