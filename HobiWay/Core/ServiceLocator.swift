//
//  ServiceLocator.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 8.10.2024.
//

import Foundation
final class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    private init() {}
    
    private var services: [String: Any] = [:]
    
    func addService<T>(_ service: T) {
        let key = "\(T.self)"
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = "\(T.self)"
        return services[key] as? T
    }
}
