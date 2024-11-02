//
//  AuthSignInViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import Foundation

final class AuthSignInViewViewModel : ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var remember: Bool = false
    @Published private var isFirstLaunch = false
    @Published var openInformationView = false
    @Published var openhomeView = false
    @Published  var isSignInSuccessful = false
    
    
    
    
    
    func signIn() async throws{
        guard ValidationHelper.isNonEmpty(email),ValidationHelper.isNonEmpty(password) else{
            throw AuthError.custom(message: "Email or Password is empty")
        }
        
        guard ValidationHelper.isValidEmail(email) else {
            throw AuthError.custom(message: "Email is not valid form.")
        }
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            do{
                _ = try await authManager.signIn(email: email, password: password)
                
                if remember{
                    UserDefaults.standard.set(true, forKey: "isRemembered")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                }
                
            }catch{
                throw AuthError.userNotFound
            }
        }
    }
    
    
    
    func googleSignIn() async throws {
        
        do{
            let helper  = SignInGoogleHelper()
            let token = try await helper.signIn()
            
            if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
                _ = try await authManager.signInWithGoogle(tokens: token)
            }
        }catch{
            throw AuthError.signInFailed
        }
        
        
        
    }
    
    
    
    func openInformationViewFunc() async throws {
        
        
        if let authManager : FirebaseAuthManager = ServiceLocator.shared.getService(){
            let userId = try  authManager.getAuthenticatedUser().uid
            
            if let firestoreService : FirestoreService = ServiceLocator.shared.getService(){
                
                if let userData : UserModel = try await firestoreService.getDocumentWhere(from: "users", where: [(field: "id", value: userId)]){
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                       if userData.age == 0 {
                                           self.openInformationView = true
                                       } else {
                                           self.openhomeView = true
                                       }
                                   }
                   
                }
                
            }
        }
        
    }
    
    
}


