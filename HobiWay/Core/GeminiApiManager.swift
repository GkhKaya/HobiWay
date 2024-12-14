//
//  GeminiApiManager.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/12/24.
//

import Foundation
import GoogleGenerativeAI

final class GeminiApiManager: ObservableObject {
    @Published var progress: Bool = false
    @Published var result: String = ""
    
    public func generateTextToText(prompt: String) async throws {
        let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: APIKey.default)
        DispatchQueue.main.async { self.progress = true } // Başlat
        do {
            let response = try await model.generateContent(prompt)
            DispatchQueue.main.async {
                self.result = response.text ?? "Yanıt boş"
                self.progress = false
            }
        } catch let error {
            DispatchQueue.main.async {
                self.result = "Hata: \(error.localizedDescription)"
                self.progress = false
            }
        }
    }
}
