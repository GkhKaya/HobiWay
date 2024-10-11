//
//  ProjectError.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 10.10.2024.
//

import Foundation

enum AuthError: LocalizedError {
    
    case unknown
    case userNotFound
    case wrongPassword
    case emailAlreadyInUse
    case invalidEmail
    case weakPassword
    case userDisabled
    case tooManyRequests
    case operationNotAllowed
    case passwordResetFailed
    case emailVerificationFailed
    case signInFailed
    case custom(message: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "An unknown error occurred. Please try again."
        case .userNotFound:
            return "No account found for the provided credentials."
        case .wrongPassword:
            return "The password entered is incorrect."
        case .emailAlreadyInUse:
            return "The email address is already in use by another account."
        case .invalidEmail:
            return "The email address is not valid."
        case .weakPassword:
            return "The password must be at least 6 characters long."
        case .userDisabled:
            return "This user account has been disabled."
        case .tooManyRequests:
            return "Too many requests have been made. Please try again later."
        case .operationNotAllowed:
            return "This operation is not allowed. Please contact support."
        case .passwordResetFailed:
            return "Failed to send password reset email."
        case .emailVerificationFailed:
            return "Failed to send email verification."
        case .signInFailed:
            return "Failed to sign in. Please check your credentials."
        case .custom(let message):
            return message
        }
    }
}
