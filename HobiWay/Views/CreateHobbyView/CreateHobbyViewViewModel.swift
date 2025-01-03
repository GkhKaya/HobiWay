//
//  CreateHobbyViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/5/24.
//

import SwiftUI

@MainActor
final class CreateHobbyViewViewModel: ObservableObject {
    @Published var hobbyName: String = ""
    @Published var selectedLanguage: String = ""
    @Published var selectedBudget: String? = nil
    @Published var selectedLevel: String? = nil
    @Published var selectedMunite: Int? = nil
    @Published var explainWhyText: String = ""
    @Published var prompt: String = ""
    @Published var errorMessage: LocalizedStringKey?
    @Published var showError: Bool = false
    @Published var progress: Bool = false
    
    private let firestoreService = FirestoreService()
    private let userManager = FirebaseAuthManager()
    
    func validateInputs(step: Int) {
        switch step {
        case 0:
            if hobbyName.isEmpty {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.hobbyNameRequired.rawValue.locale()
            }
        case 1:
            if selectedBudget == nil {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.budgetRequired.rawValue.locale()
            }
        case 2:
            if selectedLanguage.isEmpty {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.languageRequired.rawValue.locale()
            }
        case 3:
            if selectedLevel == nil {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.levelRequired.rawValue.locale()
            }
        case 4:
            if selectedMunite == nil || selectedMunite! % 5 != 0 {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.muniteRequired.rawValue.locale()
            }
        case 5:
            if explainWhyText.isEmpty {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.resonRequired.rawValue.locale()
            }
        default:
            break
        }
    }
    
 
    
    func createPrompt() {
        guard !hobbyName.isEmpty,
              !selectedLanguage.isEmpty,
              let budget = selectedBudget, !budget.isEmpty,
              let level = selectedLevel, !level.isEmpty,
              let munite = selectedMunite, munite % 5 == 0,
              !explainWhyText.isEmpty else {
            showError = true
            errorMessage = LocalKeys.CreateHobbyViewErrorCode.pleaseFillAllRequiredFieldsCorrectly.rawValue.locale()
            return
        }
        
        self.prompt = """
        I want to create a hobby plan with this information.
        Name of the hobby to learn: \(self.hobbyName)
        Language of plan: \(self.selectedLanguage)
        Budget: \(self.selectedBudget ?? "")
        Level of learning: \(self.selectedLevel ?? "")
        Time per day: \(self.selectedMunite ?? 0)
        Why do you want to learn this hobby? \(self.explainWhyText)
        Please output in JSON format.
        """
        print(self.prompt)
    }
    
    
    
    @MainActor
    func createHobbyPlan() async -> Bool {
        let geminiManager = GeminiApiManager()
        
        createPrompt()
        if showError {
            return false
        }
        
        do {
            self.progress = true
            // Gemini'den JSON yanıtını al
            try await geminiManager.generateTextToText(prompt: prompt)
  
          
            
            // Gemini'den gelen sonucu kontrol et
            if geminiManager.result.isEmpty {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.failedToGenerateHobbyPlan.rawValue.locale()
                self.progress = false
                return false
                
            }
            
            // JSON string'i temizle
            var cleanedJSON = geminiManager.result.trimmingCharacters(in: .whitespacesAndNewlines)
            cleanedJSON = cleanedJSON.replacingOccurrences(of: "```json", with: "")
            cleanedJSON = cleanedJSON.replacingOccurrences(of: "```", with: "")
            cleanedJSON = cleanedJSON.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // JSON'ı parse et
            guard let jsonData = cleanedJSON.data(using: .utf8),
                  var jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .fragmentsAllowed) as? [String: Any] else {
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.failedToGenerateHobbyPlan.rawValue.locale()
                self.progress = false
                self.progress = false
                return false
            }
            
            // Kullanıcı bilgilerini al
            let authUser = try userManager.getAuthenticatedUser()
            let userId = authUser.uid
            
            // UUID ve user_id ekle
            let documentId = UUID().uuidString
            jsonObject["id"] = documentId
            jsonObject["user_id"] = userId
            
            // Firestore'a kaydet - document ID'yi direkt olarak belirtiyoruz
            try await firestoreService.db.collection("hobbies").document(documentId).setData(jsonObject)
            
            let userRef = firestoreService.db.collection("users").document(userId)
                   let userSnapshot = try await userRef.getDocument()
                   
            if userSnapshot.exists, let userData = userSnapshot.data() {
                       // Eğer 'hobbies' dizisi varsa, yeni hobbyId'yi ekleyin
                       var hobbies = userData["hobbies"] as? [String] ?? [String]()
                       hobbies.append(documentId)  // Yeni hobbyId'yi ekle
                       
                       // Kullanıcı belgesini güncelle
                       try await userRef.updateData([
                           "hobbies": hobbies  // 'hobbies' dizisini güncelle
                       ])
                       print("User's hobby added successfully.")
                   } else {
                       print("User not found.")
                   }
                    self.progress = false
                   return true
            
            
        } catch {
            
            return false
        }
    }
}
