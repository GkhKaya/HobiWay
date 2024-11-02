//
//  HomeViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 17.10.2024.
//

import Foundation


final class HomeViewViewModel: ObservableObject {
    @Published var userData : UserModel?
    @Published var openAddInformationView: Bool = false
    
    func getAuthedUserData() async throws {
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService() {
            let authedUserData = try authManager.getAuthenticatedUser()
            
            if let firestoreService : FirestoreService = ServiceLocator.shared.getService() {
                userData = try await firestoreService.getDocumentWhere(from: "users", where: [("id", authedUserData.uid)])
            }
        }
    }
    
    
    func openAddInformationPage() {
        if userData?.fullName.isEmpty == true{
            openAddInformationView = true
        }
    }
    
    
    
}
