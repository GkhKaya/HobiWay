//
//  TabBarView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 11/24/24.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView(){
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "plus.app")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "heart")
                }
            ContentView()
                .tabItem {
                    Image(systemName: "gear")
                }
        }.tint(.libertyBlue)
    }
}

#Preview {
    TabBarView()
}
