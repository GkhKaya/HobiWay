//
//  NetworkMonitor.swift
//  HobiWay
//
//  Created by Gökhan Kaya on 18.03.2025.
//


import Network
import Foundation

class NetworkMonitor: ObservableObject {
    @Published var isConnected: Bool = false
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                if self?.isConnected == true {
                    print("Internet connection restored")
                } else {
                    print("Internet connection lost")
                }
            }
        }
        monitor.start(queue: queue)
        checkConnection() // İlk başlatıldığında mevcut durumu kontrol et
    }
    
    func checkConnection() {
        isConnected = monitor.currentPath.status == .satisfied
        print("Manual connection check: \(isConnected ? "Connected" : "Not connected")")
    }
    
    deinit {
        monitor.cancel()
    }
}
