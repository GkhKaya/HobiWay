//
//  HomeViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 17.10.2024.
//

import Foundation

@MainActor
final class HomeViewViewModel: ObservableObject {
    @Published var userData: UserModel?
    @Published var openAddInformationView: Bool = false
    @Published var userHobbies: [String] = []
    @Published var matchedHobbies: [HobbyModel] = []
    @Published var matchedHobbiess: [[String: Any]] = []
    @Published var isLoading: Bool = false
    
    private let isGuest: Bool = UserDefaults.standard.bool(forKey: "guest") // Misafir durumu
    
    func getAuthedUserData() async throws {
        // Misafir kullanıcılar için bu fonksiyonu atla
        guard !isGuest else {
            userData = UserModel(
                id: "guest",
                mail: "Misafir Kullanıcı",
                fullName: "Misafir",
                interests: [], // Zorunlu alan için varsayılan boş dizi
                gender: nil,
                phoneNumber: nil,
                age: 0,
                imageUrl: nil,
                createdAt: Date(), // Zorunlu alan için mevcut tarih
                inroduceYourself: nil,
                hobbies: []
            )
            return
        }
        
        if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
            let authedUserData = try authManager.getAuthenticatedUser()
            
            if let firestoreService: FirestoreService = ServiceLocator.shared.getService() {
                userData = try await firestoreService.getDocumentWhere(from: "users", where: [("id", authedUserData.uid)])
                if let user = userData {
                    userHobbies = user.hobbies
                }
            }
        }
    }
    
    func fetchHobbies() async throws {
        guard let firestoreService: FirestoreService = ServiceLocator.shared.getService() else {
            return
        }
        
        if isGuest {
            // Misafir kullanıcılar için UserDefaults’tan hobileri çek
            let localHobbies = loadLocalHobbies()
            await MainActor.run {
                self.matchedHobbies = localHobbies
            }
        } else {
            // Oturum açmış kullanıcılar için Firestore’dan hobileri çek
            guard !userHobbies.isEmpty else {
                return
            }
            
            var fetchedHobbies: [HobbyModel] = []
            
            do {
                for hobbyId in userHobbies {
                    let hobby: [HobbyModel] = try await firestoreService.getDocumentsWhere(
                        from: "hobbies",
                        where: [("id", hobbyId)]
                    )
                    
                    fetchedHobbies.append(contentsOf: hobby)
                }
                
                await MainActor.run {
                    self.matchedHobbies = fetchedHobbies
                }
            } catch {
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound, .typeMismatch:
                        break
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func fetchUserAndMatchedHobbies() async throws {
        isLoading = true
        
        defer {
            isLoading = false
        }
        
        try await getAuthedUserData()
        try await fetchHobbies()
    }
    
    func openAddInformationPage() {
        if userData?.fullName.isEmpty == true {
            openAddInformationView = true
        }
    }
    
    // UserDefaults’tan yerel hobileri yükleme
    private func loadLocalHobbies() -> [HobbyModel] {
        guard let localHobbies = UserDefaults.standard.array(forKey: "localHobbies") as? [[String: Any]] else { return [] }
        return localHobbies.compactMap { hobbyDict in
            guard let jsonData = try? JSONSerialization.data(withJSONObject: hobbyDict),
                  let hobby = try? JSONDecoder().decode(HobbyModel.self, from: jsonData) else { return nil }
            return hobby
        }
    }
}
