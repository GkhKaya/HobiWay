//
//  ProjectButtons.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 19.10.2024.
//

import SwiftUI

struct ButtonWithBg: View {
    var action: () -> Void
    var title : LocalizedStringKey
    var body: some View {
        Button{
            action()
        }label:{
            Text(title)
                .foregroundStyle(.white)
                .modifier(Px16Bold())
               
        }
        .padding()
        .padding(.horizontal,ProjectPaddings.large.rawValue)
        .background(.safetyOrange)
        .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
        .padding(.top,ProjectPaddings.normal.rawValue)
    }
}

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        Button{
            if presentationMode.wrappedValue.isPresented{
                presentationMode.wrappedValue.dismiss()
            }
        }label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.libertyBlue)
        }
        
        
    }
}

