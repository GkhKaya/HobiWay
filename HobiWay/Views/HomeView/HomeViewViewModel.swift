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
    
    func getAuthedUserData() async throws {
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
                // Kritik hata durumlarını sessizce handle et
                switch decodingError {
                case .keyNotFound, .typeMismatch:
                    break
                default:
                    break
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
}
