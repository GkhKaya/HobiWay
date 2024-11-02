//
//  sometest.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 24.10.2024.
//

import SwiftUI

struct sometest: View {
    var body: some View {
        HStack {
            Text("Gastronamy")
                .foregroundStyle(Color.winterHaven)
                .modifier(Px16Bold())
                .frame(height: 50) // Yalnızca yükseklik sabitleniyor
                .padding(.horizontal, 16) // Yatayda boşluk ayarlanıyor
                .background(Color.libertyBlue)
                .cornerRadius(12)
                .shadow(radius: 3)
            Spacer()
            Text("Music")
                .foregroundStyle(Color.winterHaven)
                .modifier(Px16Bold())
                .frame(height: 50) // Yalnızca yükseklik sabitleniyor
                .padding(.horizontal, 16) // Yatayda boşluk ayarlanıyor
                .background(Color.libertyBlue)
                .cornerRadius(12)
                .shadow(radius: 3)
        }
    }
}

#Preview {
    sometest()
}
