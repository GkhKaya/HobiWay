//
//  sometest.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 24.10.2024.
//

import SwiftUI

struct SomeTest: View {
    @Binding var text: String
    @StateObject private var geminiApi = GeminiApiManager() // ObservableObject olarak kullanılıyor
    
    var body: some View {
        VStack {
            VStack {
                TextField("Search", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    Task {
                        do {
                            try await geminiApi.generateTextToText(prompt: text)
                        } catch {
                            print("Hata oluştu: \(error.localizedDescription)")
                        }
                    }
                }) {
                    Text("Gönder")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()

            if geminiApi.progress {
                ProgressView("Yükleniyor...") // Yükleniyor göstergesi
                    .padding()
            } else {
                ScrollView {
                    Text(geminiApi.result) // Sonuç metni
                        .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    SomeTest(text: .constant("Lütfen bana 20 yaşında bir erkek için flüt hobisi için bir plan hazırla. Bu kişinin bu hobi için bütçesi orta düzeyde. Başlangıç seviyesi ise beginner. Günlük 20 dakikasını ayırabilir. En çok görsel öğrenme tekniğinden verim alıyor. Ana dili Türkçe ve ileri seviye İngilizce biliyor. Bu bilgiler ile detaylı bir plan oluştur ve JSON olarak ver."))
}
