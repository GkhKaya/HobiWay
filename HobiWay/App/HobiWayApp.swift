//
//  HobiWayApp.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 4.10.2024.
//

import SwiftUI
import FirebaseCore
import Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}

@main
struct HobiWayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    init(){
        let firebaseAuthManager = FirebaseAuthManager()
        ServiceLocator.shared.addService(firebaseAuthManager)
        
        FirebaseApp.configure()

        let firestoreService = FirestoreService()
        ServiceLocator.shared.addService(firestoreService)

     
    }
    
  
    var body: some Scene {
        WindowGroup {
            MainRoot()
        }
    }
}
