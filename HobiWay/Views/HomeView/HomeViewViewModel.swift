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
    
    func getAuthedUserData() async throws {
           if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
               let authedUserData = try authManager.getAuthenticatedUser()
               
               if let firestoreService: FirestoreService = ServiceLocator.shared.getService() {
                   userData = try await firestoreService.getDocumentWhere(from: "users", where: [("id", authedUserData.uid)])
                   if let user = userData {
                       userHobbies = user.hobbies
                       print("User hobby IDs: \(userHobbies)")
                   } else {
                       print("User data could not be found.")
                   }
               } else {
                   print("FirestoreService not available.")
               }
           } else {
               print("FirebaseAuthManager not available.")
           }
       }

    func fetchMatchedHobbies() async throws {
        print("calistim")
        guard !userHobbies.isEmpty else {
            print("No hobby IDs available to fetch.")
            return
        }
        
        guard let firestoreService: FirestoreService = ServiceLocator.shared.getService() else {
            print("FirestoreService not available.")
            return
        }
        
        var fetchedHobbies: [HobbyModel] = []
        
        for hobbyID in userHobbies {
            print("calistim 1")
            do {
                // Firestore'dan veri çekme
                if let hobby: HobbyModel = try await firestoreService.getDocumentWhere(
                    from: "hobbies",
                    where: [("id", hobbyID)]
                ) {
                    print("Fetched hobby: \(hobby)")
                    fetchedHobbies.append(hobby)
                    print("calistim 2")
                } else {
                    print("No hobby found for ID: \(hobbyID)")
                }
            } catch {
                print("Error fetching hobby for ID: \(hobbyID), error: \(error.localizedDescription)")
            }
        }
        
        matchedHobbies = fetchedHobbies
        print("Matched hobbies: \(matchedHobbies)")
    }
    
    func fetchUserAndMatchedHobbies() async throws {
        // Kullanıcı verilerini al
        try await getAuthedUserData()
        
        // Elde edilen kullanıcı verilerine dayanarak hobileri al
        try await fetchMatchedHobbies()
    }
    

    func openAddInformationPage() {
        if userData?.fullName.isEmpty == true {
            openAddInformationView = true
        }
    }
}
