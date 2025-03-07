//
//  HobbyModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/23/24.
//

import Foundation


struct HobbyModel: Codable, Identifiable {
    let id: String
    let userID: String
    let hobbyName: String
    let budget: String
    let language: String
    let learningMotivation: String
    let learningLevel: String
    let totalDuration: String?
    let plan: Plan
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case hobbyName = "hobby_name"
        case budget
        case language
        case totalDuration = "total_duration"
        case learningMotivation = "learning_motivation"
        case learningLevel = "learning_level"
        case plan
    }
    
    struct Plan: Codable {
        let phases: [Phase]
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case phases
            case description
        }
    }
    
    struct Phase: Codable {
        let duration: String?
        let goals: [String]?
        let resources: [String]?
        let description: String?
        
        enum CodingKeys: String, CodingKey {
            case duration
            case goals
            case resources
            case description
        }
    }
}
