import Foundation
import SwiftUI

@MainActor
final class UpdateEmailViewViewModel: ObservableObject {
    @Published var newEmail: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    func updateEmail() async {
        guard ValidationHelper.isNonEmpty(newEmail) else {
            errorMessage = LocalKeys.AuthErrorCode.authFieldsEmpty.rawValue.locale()
            showAlert = true
            return
        }
        
        guard ValidationHelper.isValidEmail(newEmail) else {
            errorMessage = LocalKeys.AuthErrorCode.invalidMail.rawValue.locale()
            showAlert = true
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
                try await authManager.updateEmail(newEmail: newEmail)
                isSuccess = true
            }
        } catch {
            errorMessage = LocalKeys.AuthErrorCode.emailResetFailed.rawValue.locale()
            showAlert = true
        }
    }
} 
