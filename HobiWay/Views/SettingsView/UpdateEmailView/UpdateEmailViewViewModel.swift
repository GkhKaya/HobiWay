import Foundation
import SwiftUI

@MainActor
final class UpdateEmailViewViewModel: ObservableObject {
    @Published var newEmail: String = ""
    @Published var currentPassword: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false

    func updateEmail() async {
        // Giriş kontrolleri
        guard ValidationHelper.isNonEmpty(newEmail), ValidationHelper.isNonEmpty(currentPassword) else {
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
                do{
                    try await authManager.reauthenticateUser(currentPassword: currentPassword)
                }catch{
                    errorMessage = LocalKeys.SettingsViewErrorCode.yourCurrentPasswordIsWrong.rawValue.locale()
                    showAlert = true
                    return
                }

                try await authManager.updateEmail(newEmail: newEmail)
                
                isSuccess = true
                print("Email updated successfully to \(newEmail)")
            } else {
                print("Error: AuthManager not found.")
            }
        } catch {
            errorMessage = LocalKeys.SettingsViewErrorCode.emailUpdateFailed.rawValue.locale()
            showAlert = true
            print("Error updating email: \(error.localizedDescription)")
        }
    }

  
}
