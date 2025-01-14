import Foundation
@MainActor
final class SettingsViewViewModel: ObservableObject {
    @Published var userData: UserModel?
    @Published var isLoading: Bool = false
    @Published var totalHobbies: Int = 0
    
    private let authManager = FirebaseAuthManager()
    
    func fetchUserData() async throws {
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
        
        // Toplam hobi sayısını hesapla
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
} 
