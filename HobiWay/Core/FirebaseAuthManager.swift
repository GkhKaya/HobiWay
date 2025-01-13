//
//  AuthManager.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthManager{
    
    init() {}
    
    
    func getAuthenticatedUser() throws -> AuthDataResultModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func getProvider() throws{
        guard (Auth.auth().currentUser?.providerData) != nil else{
            throw (URLError(.badServerResponse))
        }
        
    }
    
    
    
    func signOut() throws {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            throw signOutError
        }
    }
    
    
}

//MARK: SIGN IN EMAIL
extension FirebaseAuthManager{
    func createUser(email:String,password:String) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let result  = AuthDataResultModel(user: authDataResult.user)
       /*let user = UserModel(auth: result)
        try await FirestoreUserManager.shared.createUser(user:user)*/
        return result
    }
    
    func signIn(email:String,password:String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let result = AuthDataResultModel(user: authDataResult.user)
        return result
        
    }
    
    func resetUsersPassword(email:String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func sendVerificationEmail() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        try await user.sendEmailVerification()
    }
    
    
    
}

//MARK: SIGN IN SSO
extension FirebaseAuthManager{
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func signIn(credential : AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with:credential)
        return AuthDataResultModel(user: authDataResult.user)
        
    }
}



//MARK: Manage Account

extension FirebaseAuthManager{
    func checkIfEmailIsVerified() async throws -> Bool {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.reload()
        
        return user.isEmailVerified
    }
    
    
    func updateEmail(newEmail: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        // Kullanıcıdan önce doğrulama iste
        try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
    }
    
    
    func updatePassword(newPassword: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        try await user.updatePassword(to: newPassword)
    }
    
    
    func reauthenticateUser(currentPassword: String) async throws {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            throw AuthError.userNotFound
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        
        // Kullanıcıyı yeniden doğrula (Reauthentication)
        try await user.reauthenticate(with: credential)
    }
    
    func deleteAccount()async throws{
        guard let user = Auth.auth().currentUser else {
            throw AuthError.userNotFound
        }
        
        try await user.delete()
    }
    
}
