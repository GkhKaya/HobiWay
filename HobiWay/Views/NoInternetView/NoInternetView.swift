//
//  NoInternetView.swift
//  HobiWay
//
//  Created by Gökhan Kaya on 18.03.2025.
//



import SwiftUI

struct NoInternetView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor // Bağlantı durumunu izlemek için
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 60))
                .foregroundColor(.red)
                .padding(.bottom, 10)
            
            Text(LocalKeys.NoInternetViewKeys.noInternetConnection.rawValue.locale())
                .modifier(Px16Bold())
                
            
            Text(LocalKeys.NoInternetViewKeys.offlineMessage.rawValue.locale())
                .modifier(Px12Regular())
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, ProjectPaddings.medium.rawValue)
            
            Button(action: {
                if let url = URL(string: "App-Prefs:root=WIFI") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text(LocalKeys.NoInternetViewKeys.openSettings.rawValue.locale())
                    .modifier(Px16Bold())
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color.safetyOrange)
                    .foregroundColor(.white)
                    .cornerRadius(ProjectRadius.normal.rawValue)
            }
            
            Button(action: {
                networkMonitor.checkConnection() // Manuel kontrol
            }) {
                Text(LocalKeys.NoInternetViewKeys.retry.rawValue.locale())
                    .font(.headline)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemBackground)) // Tema uyumlu arka plan
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // Bağlantı geri geldiğinde otomatik geçiş
        .onChange(of: networkMonitor.isConnected) { newValue in
            if newValue {
                print("Internet restored, switching to MainRoot")
            }
        }
    }
}

#Preview {
    NoInternetView()
        .environmentObject(NetworkMonitor())
}
