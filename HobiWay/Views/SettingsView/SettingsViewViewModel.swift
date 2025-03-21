import Foundation
import SwiftUI

@MainActor
final class SettingsViewViewModel: ObservableObject {
    @Published var userData: UserModel?
    @Published var isLoading: Bool = false
    @Published var totalHobbies: Int = 0
    @Published var isGuest: Bool = UserDefaults.standard.bool(forKey: "guest")
    @AppStorage("isRemembered") private var isLoggedIn: Bool = true
    
    private let authManager = FirebaseAuthManager()
    
    func fetchUserData() async throws {
        if isGuest {
            let localHobbies = UserDefaults.standard.array(forKey: "localHobbies") as? [[String: Any]] ?? []
            totalHobbies = localHobbies.count
            isLoading = false
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        guard let firestoreService: FirestoreService = ServiceLocator.shared.getService() else {
            return
        }
        
        let authedUser = try authManager.getAuthenticatedUser()
        
        userData = try await firestoreService.getDocumentWhere(
            from: "users",
            where: [("id", authedUser.uid)]
        )
        
        if let hobbies = userData?.hobbies {
            totalHobbies = hobbies.count
        }
    }
    
    func getGenderString() -> String {
        guard let gender = userData?.gender else { return "Not specified" }
        switch gender {
        case 0:
            return "Male"
        case 1:
            return "Female"
        default:
            return "Other"
        }
    }
    
    func signOut() async {
        if isGuest {
            // Misafir kullanıcı için çıkış yap
            UserDefaults.standard.set(false, forKey: "guest")
            UserDefaults.standard.removeObject(forKey: "localHobbies") // Yerel hobileri sıfırla (opsiyonel)
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
            return
        }
        
        // Oturum açmış kullanıcı için çıkış yap
        guard let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() else {
            return
        }
        
        do {
            try authManager.signOut()
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
        } catch {
            // Hata durumunda bir şey yapmıyoruz, print kaldırıldı
        }
    }
    
    func deleteAccount() async throws {
        guard !isGuest else {
            await signOut()
            return
        }
        
        guard let authManager: FirebaseAuthManager = ServiceLocator.shared.getService(),
              let firestoreManager: FirestoreService = ServiceLocator.shared.getService() else {
            return
        }
        
        do {
            let userData = try authManager.getAuthenticatedUser()
            try await firestoreManager.deleteDocument(from: "users", documentId: userData.uid)
            try await authManager.deleteAccount()
            
            DispatchQueue.main.async {
                self.isLoggedIn = false
            }
        } catch {
            // Hata durumunda bir şey yapmıyoruz, print kaldırıldı
            throw error
        }
    }
    
    func getInitials(from fullName: String) -> String {
        let words = fullName.split(separator: " ")
        let initials = words.compactMap { $0.first?.uppercased() }
        return initials.joined()
    }
}
