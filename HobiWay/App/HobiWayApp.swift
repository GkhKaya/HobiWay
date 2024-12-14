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
            SomeTest(text: .constant("Lutfen bana 20 yaşında bir erkeke icin flüt hobisi için bir plan hazırla. Bu kisinin bu hobi icin bütçesi orta düzeyde. Baslangic seviyesi ise beginner. Günlük 20 dakikasını ayırabilir. en cok görsel öğrenme tekniğinden verim alıyor. Ana dili Türkçe ve ileri seviye ingilizce biliyor.bu bilgiler ile detaylı bir plan oluştur ve json olarak ver"))
        }
    }
}
