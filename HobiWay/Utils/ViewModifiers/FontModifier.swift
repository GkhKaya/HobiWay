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
        content.responsiveFont(name: "Poppins-ExtraBold", size: 32).foregroundStyle(.libertyBlue)
    }
}

struct Px32Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Bold", size: 32).foregroundStyle(.libertyBlue)
    }
}

struct Px32Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Regular", size: 32).foregroundStyle(.libertyBlue)
    }
}

struct Px24Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Bold", size: 24).foregroundStyle(.libertyBlue)
    }
}

struct Px24Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Regular", size: 24).foregroundStyle(.libertyBlue)
    }
}

struct Px18Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Bold", size: 18).foregroundStyle(.libertyBlue)
    }
}

struct Px18Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Regular", size: 18).foregroundStyle(.libertyBlue)
    }
}

struct Px16Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Bold", size: 16).foregroundStyle(.libertyBlue)
    }
}

struct Px16BoldItalic: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-BoldItalic", size: 16).foregroundStyle(.libertyBlue)
    }
}

struct Px16Light: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Light", size: 16).foregroundStyle(.libertyBlue)
    }
}

struct Px16Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Regular", size: 16).foregroundStyle(.libertyBlue)
    }
}

struct Px12Bold: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Bold", size: 12).foregroundStyle(.libertyBlue)
    }
}

struct Px12Light: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppins-Light", size: 12).foregroundStyle(.libertyBlue)
    }
}

struct Px12Regular: ViewModifier {
    func body(content: Content) -> some View {
        content.responsiveFont(name: "Poppin-Regular", size: 12).foregroundStyle(.libertyBlue)
    }
}
