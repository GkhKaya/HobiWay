//
//  AuthSignUpViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 7.10.2024.
//

import Foundation

final class AuthSignUpViewViewModel : ObservableObject{
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    
    func signUp() async throws{
        guard ValidationHelper.isNonEmpty(email), ValidationHelper.isNonEmpty(password) else{
            throw AuthError.custom(message: "Email or password is empty")
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            throw AuthError.custom(message: "Email is not valid")
        }
        
        guard ValidationHelper.isValidPassword(password) else {
            throw AuthError.custom(message: "Password must have at least 8 characters, one uppercase, one lowercase, one number and one special character")
        }
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            do{
                let returnerUserData = try await authManager.createUser(email: email, password: password)
                
                let newUser = UserModel(
                    id: returnerUserData.uid,
                    mail: email,
                    fullName: "",
                    interests: [],
                    gender: 1,
                    phoneNumber: "",
                    age: 0,
                    imageUrl: "",
                    createdAt: Date(),
                    inroduceYourself: ""
                )
                
                
                if let firestoreService: FirestoreService = ServiceLocator.shared.getService() {
                    try await firestoreService.setDocument(documentId: returnerUserData.uid, in: "users", data: newUser)
                    print("Successfully created user and saved to Firestore with ID: \(returnerUserData.uid)")
                } else {
                    throw AuthError.custom(message: "FirestoreService not found")
                }
                
                print("Successfully created user and saved to Firestore: \(returnerUserData.email!)")
            }catch{
                throw AuthError.emailAlreadyInUse
            }
        }
    }
}
