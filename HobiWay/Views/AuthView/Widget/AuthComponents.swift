//
//  AuthComponents.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 14.10.2024.
//

import Foundation
import SwiftUI

struct RememberStyle : ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundStyle(.libertyBlue)
                    .animation(.easeInOut, value: configuration.isOn) // iOS 16 uyumluluğu
                Text(LocalKeys.Auth.rememberMe.rawValue.locale())
                    .modifier(Px16Light())
                    .foregroundStyle(Color.libertyBlue)
            }
        }.tint(.primary)
    }
}

#Preview(){
    AuthSignInView()
}
