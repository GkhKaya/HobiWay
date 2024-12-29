//
//  MainRoot.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 14.10.2024.
//

import SwiftUI

struct MainRoot: View {
    @AppStorage("isRemembered") var isLoggedIn: Bool = false

    var body: some View {
        if isLoggedIn{
            TabBarView()
        }else{
            AuthRootView()
        }
    }
}

#Preview {
    MainRoot()
}
