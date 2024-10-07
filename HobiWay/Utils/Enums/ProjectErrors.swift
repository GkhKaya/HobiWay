//
//  ProjectErrors.swift
//  Inovel
//
//  Created by Gokhan Kaya on 28.07.2024.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case decodingError
    case emptyField
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .requestFailed:
            return "İstek başarısız oldu."
        case .decodingError:
            return "Veri çözümleme hatası."
        case .emptyField:
            return "Lütfen tüm değerleri doldurunuz."
        case .unknownError:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}

enum AppError: Error, LocalizedError {
    case networkError(String)
    case invalidInput(String)
    case authenticationError
    case databaseError(String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Ağ hatası: \(message)"
        case .invalidInput(let field):
            return "Geçersiz giriş: \(field)"
        case .authenticationError:
            return "Kimlik doğrulama hatası."
        case .databaseError(let message):
            return "Veritabanı hatası: \(message)"
        case .unknownError:
            return "Bilinmeyen bir hata oluştu."
        }
    }
}

enum FirestoreError : Error,LocalizedError{
    case emptyField(String)
    case anError
    
    var errorDescription: String? {
        switch self{
        case .emptyField(let field):
            return "\(field) boş olamaz."
        case .anError:
            return "Bir hata oluştu"
        }
    }
}
    
    
    enum AuthError: Error, LocalizedError {
        case invalidCredentials
        case registeredUser
        case userNotFound
        case accountLocked
        case networkError
        case unknownError
        case emptyField(String)
        case invalidEmailFormat
        case wrongPassword
        case weakPassword
        
        var errorDescription: String? {
            switch self {
            case .invalidCredentials:
                return "Geçersiz kullanıcı adı veya şifre."
            case .registeredUser:
                return "Bu bilgilere ait bir kullanıcı var."
            case .userNotFound:
                return "Kullanıcı bulunamadı."
            case .accountLocked:
                return "Hesap kilitli. Lütfen destek ile iletişime geçin."
            case .networkError:
                return "Ağ hatası. Lütfen bağlantınızı kontrol edin."
            case .unknownError:
                return "Bilinmeyen bir hata oluştu."
            case .emptyField(let field):
                return "\(field) boş olamaz"
            case .invalidEmailFormat:
                return "Geçersiz E-Posta"
            case .wrongPassword:
                return "Hatalı Şifre."
            case .weakPassword:
                return "Şifreniz en az 8 karakter ve büyük karakter, küçük karakter, sayı ve özel karakter içermelidir."
            }
        }
    }
        

