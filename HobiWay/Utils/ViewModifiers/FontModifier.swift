//
//  FontModifier.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 4.10.2024.
//

import Foundation
import SwiftUI

struct ResponsiveFontModifier: ViewModifier {
    let baseFontName: String
    let baseFontSize: CGFloat
    
    @Environment(\.sizeCategory) var sizeCategory
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: baseFontSize)
        return content.font(.custom(baseFontName, size: scaledSize))
    }
}

extension View {
    func responsiveFont(name: String, size: CGFloat) -> some View {
        self.modifier(ResponsiveFontModifier(baseFontName: name, baseFontSize: size))
    }
}

struct Px32ExtraBold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-ExtraBold", size: 32)
    }
}

struct Px32Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Bold", size: 32)
    }
}

struct Px32Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Regular", size: 32)
    }
}

struct Px24Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Bold", size: 24)
    }
}

struct Px24Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Regular", size: 24)
    }
}

struct Px18Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Bold", size: 18)
    }
}

struct Px18Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Regular", size: 18)
    }
}

struct Px16Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Bold", size: 16)
    }
}

struct Px16BoldItalic: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-BoldItalic", size: 16)
    }
}

struct Px16Light: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Light", size: 16)
    }
}

struct Px16Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Regular", size: 16)
    }
}

struct Px12Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Bold", size: 12)
    }
}

struct Px12Light: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Light", size: 12)
    }
}

struct Px12Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Montserrat-Regular", size: 12)
    }
}
