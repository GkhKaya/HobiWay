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
            print("Error: Fields are empty.")
            return
        }

        guard ValidationHelper.isValidEmail(newEmail) else {
            errorMessage = LocalKeys.AuthErrorCode.invalidMail.rawValue.locale()
            showAlert = true
            print("Error: Invalid email format - \(newEmail)")
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
                print("Reauthenticating user before updating email.")
                // Kullanıcıyı yeniden doğrula
                try await authManager.reauthenticateUser(currentPassword: currentPassword)

                print("Reauthentication successful. Updating email to \(newEmail)")
                // Yeni e-posta güncellemesini gerçekleştir
                try await authManager.updateEmail(newEmail: newEmail)
                
                isSuccess = true
                print("Email updated successfully to \(newEmail)")
            } else {
                print("Error: AuthManager not found.")
            }
        } catch {
            errorMessage = handleError(error)
            showAlert = true
            print("Error updating email: \(error.localizedDescription)")
        }
    }

    private func handleError(_ error: Error) -> LocalizedStringKey {
        if let authError = error as? AuthError {
            switch authError {
            case .userNotFound:
                return LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
            case .wrongPassword:
                return LocalKeys.AuthErrorCode.weakPassword.rawValue.locale()
            default:
                return LocalKeys.AuthErrorCode.emailResetFailed.rawValue.locale()
            }
        }
        return LocalKeys.AuthErrorCode.emailResetFailed.rawValue.locale()
    }
}
