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
    
    
    func signIn() async throws{
        guard ValidationHelper.isNonEmpty(email),ValidationHelper.isNonEmpty(password) else{
            throw AuthError.custom(message: "Email or Password is empty")
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            throw AuthError.custom(message: "Email is not valid form.")
        }
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            do{
                let returnerUserData = try await authManager.signIn(email: email, password: password)
                print("Succes")
            }catch{
                throw AuthError.userNotFound
            }
        }
    }
}
