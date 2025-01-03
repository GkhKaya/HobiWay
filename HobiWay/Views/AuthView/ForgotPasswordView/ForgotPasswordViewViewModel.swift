//
//  ForgotPasswordViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 15.10.2024.
//

import Foundation

import SwiftUI


final class ForgotPasswordViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var showAlert: Bool = false
    @Published  var allertSuccesMessage : LocalizedStringKey?
    @Published  var successAlert = false
    
    
    
    func resetpAssword() async throws{
        guard ValidationHelper.isNonEmpty(email) else{
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.authFieldsEmpty.rawValue.locale()
                self.showAlert = true
            }
            return
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            DispatchQueue.main.async {
                self.errorMessage = LocalKeys.AuthErrorCode.invalidMail.rawValue.locale()
                self.showAlert = true
            }
            return
        }
        
        do{
            if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
                try await authManager.resetUsersPassword(email: email)
                Task { @MainActor in
                    self.allertSuccesMessage = LocalKeys.Auth.sendedMail.rawValue.locale()
                    self.successAlert = true
                }
                
            }
        }catch{
            Task{ @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.passwordResetFailed.rawValue.locale()
                self.showAlert = true
            }
            throw AuthError.passwordResetFailed
        }
    }
}
