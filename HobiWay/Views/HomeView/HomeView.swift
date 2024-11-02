//
//  HomeView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 14.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var isFirstSignIn: Bool = false
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                ZStack{
                    Color.winterHaven.ignoresSafeArea()
                    
                    VStack{
                        Text(LocalKeys.Auth.signInWithGoogle.rawValue.locale())
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
