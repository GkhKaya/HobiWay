//
//  ForgotPasswordViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 15.10.2024.
//

import Foundation


final class ForgotPasswordViewViewModel: ObservableObject {
    @Published var email: String = ""
    
    
    
    func resetpAssword() async throws{
        guard ValidationHelper.isNonEmpty(email) else{
            throw AuthError.custom(message: "Email can not be empty")
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            throw AuthError.custom(message: "Email is not valid form.")
        }
        
        do{
            if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
                try await authManager.resetUsersPassword(email: email)
            }
        }catch{
            throw AuthError.passwordResetFailed
        }
    }
}
