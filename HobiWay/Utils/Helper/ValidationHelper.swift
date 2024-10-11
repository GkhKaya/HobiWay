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
    
    static func isValidPassword(_ password: String) -> Bool {
        // Check if the password has at least 8 characters
        guard password.count >= 8 else {
            return false
        }
        
        // Check for at least one uppercase letter, one lowercase letter, one digit, and one special character
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasDigit = password.range(of: "[0-9]", options: .regularExpression) != nil
        let hasSpecialCharacter = password.range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) != nil
        
        return hasUppercase && hasLowercase && hasDigit && hasSpecialCharacter
    }
}
