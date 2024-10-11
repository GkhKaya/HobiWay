//
//  ValidationHelper.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 10.10.2024.
//

import Foundation


struct ValidationHelper {
    static func isNonEmpty(_ string: String) -> Bool {
        return !string.isEmpty
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
