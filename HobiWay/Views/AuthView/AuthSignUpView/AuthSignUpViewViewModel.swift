//
//  AuthSignUpViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 7.10.2024.
//

import Foundation
import SwiftUI

@MainActor
final class AuthSignUpViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: LocalizedStringKey = ""
    @Published var showSuccessAlert: Bool = false // Başarı alert'i için yeni state
    
    @MainActor
    func signUp() async throws {
        guard ValidationHelper.isNonEmpty(email), ValidationHelper.isNonEmpty(password) else {
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.authFieldsEmpty.rawValue.locale()
                self.showAlert = true
            }
            return
        }

        guard ValidationHelper.isValidEmail(email) else {
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.invalidMail.rawValue.locale()
                self.showAlert = true
            }
            return
        }

        guard ValidationHelper.isValidPassword(password) else {
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.weakPassword.rawValue.locale()
                self.showAlert = true
            }
            return
        }

        if let authManager: FirebaseAuthManager = ServiceLocator.shared.getService() {
            do {
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
                    inroduceYourself: "",
                    hobbies: []
                )

                if let firestoreService: FirestoreService = ServiceLocator.shared.getService() {
                    try await firestoreService.setDocument(documentId: returnerUserData.uid, in: "users", data: newUser)
                    self.showSuccessAlert = true
                } else {
                    Task { @MainActor in
                        self.errorMessage = LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
                        self.showAlert = true
                    }
                    throw AuthError.userNotFound
                }
            } catch {
                Task { @MainActor in
                    self.errorMessage = LocalKeys.AuthErrorCode.emailAlreadyInUse.rawValue.locale()
                    self.showAlert = true
                }
                throw AuthError.emailAlreadyInUse
            }
        }
    }
    
    func signUpApple() async{
       do{
            let helper = SignInAppleHelper()
            let tokens = try await helper.startSignInWithAppleFlow()
       
            if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
                let returnerUserData  = try await authManager.signInWithApple(tokens: tokens)
                let newUser = UserModel(
                    id: returnerUserData.uid,
                    mail: returnerUserData.email ?? "Private",
                    fullName: "",
                    interests: [],
                    gender: 1,
                    phoneNumber: "",
                    age: 0,
                    imageUrl: "",
                    createdAt: Date(),
                    inroduceYourself: "",
                    hobbies: []
                )

                if let firestoreService  :FirestoreService = ServiceLocator.shared.getService(){
                    try await firestoreService.setDocument(documentId: returnerUserData.uid, in: "users", data: newUser)
                    self.showSuccessAlert = true
                }else{
                    self.errorMessage = LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
                }
            }
        }catch{
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
                self.showAlert = true
            }
        }
    }
    
    
    func signUpGoogle() async throws {
        do{
            let helper = SignInGoogleHelper()
            let token = try await helper.signIn()
            
            if let authManaher : FirebaseAuthManager = ServiceLocator.shared.getService(){
                let returnedUserData = try await authManaher.signInWithGoogle(tokens: token)
                let newUser = UserModel(
                    id: returnedUserData.uid,
                    mail: returnedUserData.email ?? "Private",
                    fullName: "",
                    interests: [],
                    gender: 1,
                    phoneNumber: "",
                    age: 0,
                    imageUrl: "",
                    createdAt: Date(),
                    inroduceYourself: "",
                    hobbies: []
                )
                
                if let firestoreService  :FirestoreService = ServiceLocator.shared.getService(){
                    try await firestoreService.setDocument(documentId: returnedUserData.uid, in: "users", data: newUser)
                    self.showSuccessAlert = true
                }else{
                    self.errorMessage = LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
                }
            }

        }catch{
            Task { @MainActor in
                self.errorMessage = LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
                self.showAlert = true
            }
        }
    }
}
