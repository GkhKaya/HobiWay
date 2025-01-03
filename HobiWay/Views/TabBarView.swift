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
                    Image(systemName: "house")
                }
                .tag(0)
            ContentView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            CreateHobbyView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
                .tag(2)
            ContentView()
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(3)
            ContentView()
                .tabItem {
                    Image(systemName: "gear")
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
