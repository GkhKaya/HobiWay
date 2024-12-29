//
//  HobbyModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/23/24.
//

import Foundation

struct HobbyModel: Codable {
    let hobby: String
    let language: String
    let budget: String
    let level: String
    let dailyTimeCommitment: String
    let motivation: String
    let plan: [Phase]
    
    struct Phase: Codable {
        let duration: String
        let goals: [String]
        let resources: [String]
    }
}
