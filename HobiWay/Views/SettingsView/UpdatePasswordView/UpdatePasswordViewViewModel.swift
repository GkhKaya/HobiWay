import Foundation
import SwiftUI

@MainActor
final class UpdatePasswordViewViewModel: ObservableObject {
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    func updatePassword() async {
        guard ValidationHelper.isNonEmpty(currentPassword), ValidationHelper.isNonEmpty(newPassword) else {
            errorMessage = LocalKeys.AuthErrorCode.authFieldsEmpty.rawValue.locale()
            showAlert = true
            return
        }
        
        guard ValidationHelper.isValidPassword(newPassword) else {
            errorMessage = LocalKeys.AuthErrorCode.weakPassword.rawValue.locale()
            showAlert = true
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
                // Önce mevcut şifre ile yeniden doğrulama yap
                try await authManager.reauthenticateUser(currentPassword: currentPassword)
                // Sonra yeni şifreyi güncelle
                try await authManager.updatePassword(newPassword: newPassword)
                isSuccess = true
            }
        } catch {
            errorMessage = LocalKeys.AuthErrorCode.passwordResetFailed.rawValue.locale()
            showAlert = true
        }
    }
} 
