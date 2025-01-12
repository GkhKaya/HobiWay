//
//  TabBarView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 11/24/24.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab){
            HomeView()
                .tabItem{
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    Text("Home")
                }
                .tag(0)
            
            // ContentView()
            //     .tabItem {
            //         Image(systemName: selectedTab == 1 ? "magnifyingglass.circle.fill" : "magnifyingglass")
            //         Text("Search")
            //     }
            //     .tag(1)
            
            CreateHobbyView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                    Text("Create")
                }
                .tag(2)
            
            // ContentView()
            //     .tabItem {
            //         Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
            //         Text("Favorites")
            //     }
            //     .tag(3)
            
            SettingsView()
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "gear.circle.fill" : "gear")
                    Text("Settings")
                }
                .tag(4)
        }
        .navigationBarBackButtonHidden()
        .tint(.libertyBlue)
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NavigateToHome"))) { _ in
            withAnimation {
                selectedTab = 0
            }
        }
    }
}
#Preview {
    TabBarView()
}
