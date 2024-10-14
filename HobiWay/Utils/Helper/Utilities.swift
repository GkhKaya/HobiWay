//
//  Utilities.swift
//  Inovel
//
//  Created by Gokhan Kaya on 12.08.2024.
//

import Foundation
import UIKit

final class Utilities {
    static let shared = Utilities()
    
    private init() {}
    
    @MainActor
    func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        // Get the key window of the current scene
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }  // Get the active scene
            .compactMap { $0 as? UIWindowScene }  // Cast to UIWindowScene
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        
        let controller = controller ?? keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
