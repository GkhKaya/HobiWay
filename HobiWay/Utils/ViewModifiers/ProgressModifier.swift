//
//  ProgressModifier.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 1/11/25.
//

import Foundation
import SwiftUI
struct ProgressModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.progressViewStyle(CircularProgressViewStyle(tint: .safetyOrange))
            .scaleEffect(1.5)
    }
}
