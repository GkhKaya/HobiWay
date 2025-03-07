//
//  CountryCode.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 21.10.2024.
//

import Foundation


struct CountryCode: Codable, Identifiable {
    var id: String { code }
    var name: String
    var dial_code: String
    var code: String
}
