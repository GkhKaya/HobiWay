//
//  InformationViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 19.10.2024.
//
import Foundation

@MainActor
final class InformationViewViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var fullPhoneNumber: String? // Optional yapıldı
    @Published var hobbyCategoery: [HobbyCategoryModel] = []
    @Published var selectedInterests: [HobbyCategoryModel] = []
    @Published var userAboutText: String = ""
    @Published var selectedAge: Int? // Optional yapıldı
    @Published var selectedGender: Int = 0
    @Published var showProgress: Bool = false
    @Published var openHomeView: Bool = false
    
    func fetchHobbyCategory() async throws {
        if let firestoreService: FirestoreService = ServiceLocator.shared.getService() {
            do {
                showProgress = true
                let hobbyCategoery: [HobbyCategoryModel] = try await firestoreService.getAllDocument(from: "hobby_category")
                self.hobbyCategoery = hobbyCategoery
                showProgress = false
            } catch {
                print("Veri alınamadı")
            }
        }
    }
    
    func addUserInformation() async throws {
        if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
            let userData = try authManager.getAuthenticatedUser()
            
            if let firestoreService: FirestoreService = ServiceLocator.shared.getService() {
                let userDict: [String: Any] = [
                    "age": self.selectedAge as Any?, // Optional, nil olabilir
                    "full_name": self.name,
                    "gender": self.selectedGender,
                    "interests": self.selectedInterests.map { $0.id },
                    "introduce_yourself": self.userAboutText,
                    "phone_number": self.fullPhoneNumber as Any? // Optional, nil olabilir
                ]
                
                try await firestoreService.updateDocument(in: "users", documentId: userData.uid, with: userDict)
                
                DispatchQueue.main.async {
                    self.openHomeView = true
                }
            }
        }
    }
}
