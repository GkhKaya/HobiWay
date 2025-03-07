//
//  ProjectError.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 10.10.2024.
//
import SwiftUI
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
    
    var errorDescription: LocalizedStringKey? {
        switch self {
        case .unknown:
            return LocalKeys.GeneralError.unknow.rawValue.locale()
        case .userNotFound:
            return LocalKeys.AuthErrorCode.userNotFound.rawValue.locale()
        case .wrongPassword:
            return "The password entered is incorrect."
        case .emailAlreadyInUse:
            return "The email address is already in use by another account."
        case .invalidEmail:
            return "The email address is not valid.f"
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
            
        }
        
        
    }
    
    enum AppErrorCode: Error {
        case emptyField(fieldName: String)
        case invalidInput(description: String)
        case networkError
        case unknownError
        
        
        var localizedDescription: String {
            switch self {
            case .emptyField(let fieldName):
                return "\(fieldName) field cannot be empty."
            case .invalidInput(let description):
                return "Invalid input: \(description)"
            case .networkError:
                return "A network error occurred. Please try again later."
            case .unknownError:
                return "An unknown error occurred. Please contact support."
            }
        }
    }
    
    enum APIError: LocalizedError {
        case requestFailed
        case invalidResponse
        case decodingError
        case unknownError
        case custom(message: String)
        
        var errorDescription: String? {
            switch self {
            case .requestFailed:
                return "The request failed. Please try again."
            case .invalidResponse:
                return "The server returned an invalid response."
            case .decodingError:
                return "Failed to decode the server's response."
            case .unknownError:
                return "An unknown error occurred while processing the request."
            case .custom(let message):
                return message
            }
        }
    }
}
