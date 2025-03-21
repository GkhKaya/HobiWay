//
//  HobiWayApp.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 4.10.2024.
//

//
//  HobiWayApp.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 4.10.2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}

@main
struct HobiWayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @StateObject private var networkMonitor = NetworkMonitor()
    
    init() {
        let firebaseAuthManager = FirebaseAuthManager()
        ServiceLocator.shared.addService(firebaseAuthManager)
        
        FirebaseApp.configure()
        
        let firestoreService = FirestoreService()
        ServiceLocator.shared.addService(firestoreService)
    }
    
    var body: some Scene {
        WindowGroup {
            if networkMonitor.isConnected {
                MainRoot()
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            } else {
                NoInternetView()
                    .environmentObject(networkMonitor) // NetworkMonitor'u NoInternetView'a iletiyoruz
                    .preferredColorScheme(isDarkMode ? .dark : .light)
            }
        }
    }
}
