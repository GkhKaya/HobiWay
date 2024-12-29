//
//  GeminiApiManager.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/12/24.
//
import Foundation
import GoogleGenerativeAI

@MainActor
final class GeminiApiManager: ObservableObject {
    @Published var progress: Bool = false
    @Published var result: String = ""
    
    public func generateTextToText(prompt: String) async throws {
        let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: APIKey.default)
        progress = true // Başlat
        do {
            let response = try await model.generateContent(prompt)
            result = response.text ?? "Yanıt boş"
        } catch let error {
            result = "Hata: \(error.localizedDescription)"
        }
        progress = false // Tamamlandı
    }
}
