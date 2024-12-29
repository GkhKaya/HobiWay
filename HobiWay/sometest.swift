//
//  sometest.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 24.10.2024.
//

import SwiftUI

struct SomeTest: View {
    var body: some View {
            VStack {
                // Metin ve emoji birlikte
                (Text("Bu bir emoji ")
                    .font(Font.custom("SFUIText-Heavy", size: 20)) +
                 Text("🌟")
                    .font(Font.system(size: 20)) +
                 Text(" ve bir metin")
                    .font(Font.custom("SFUIText-Heavy", size: 20)))
                .padding()
                .multilineTextAlignment(.center)
            }
            .padding()
        }
}

#Preview {
    SomeTest()
}
