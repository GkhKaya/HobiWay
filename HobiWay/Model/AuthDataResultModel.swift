//
//  AuthDataResultModel.swift
//  Inovel
//
//  Created by Gokhan Kaya on 30.07.2024.
//

import Foundation
import FirebaseAuth
struct AuthDataResultModel{
    let uid: String
    let email : String?
    let photoUrl : String?
    
    init(user : User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
