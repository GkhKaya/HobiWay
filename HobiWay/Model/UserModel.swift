//
//  UserModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 15.10.2024.
//

import Foundation


struct UserModel: Codable, Identifiable {
    var id: String
    var mail: String
    var fullName: String
    var interests: [String]
    var gender: Int
    var phoneNumber: String? // Opsiyonel yap
    var age: Int
    var imageUrl: String? // Opsiyonel yap
    var createdAt: Date
    var inroduceYourself: String? // Opsiyonel yap
    var hobbies: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case mail
        case fullName = "full_name"
        case interests
        case gender
        case phoneNumber = "phone_number"
        case age
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case inroduceYourself = "inroduce_yourself"
        case hobbies = "hobbies"
    }
}
