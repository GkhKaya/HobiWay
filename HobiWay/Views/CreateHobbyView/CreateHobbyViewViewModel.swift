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
                } else if containsProhibitedContent(hobbyName) {
                    showError = true
                    errorMessage = LocalKeys.CreateHobbyViewErrorCode.adultContent.rawValue.locale()
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
         
        json field have to be english. Value can be turkish or english
        
        Please output the result in JSON format with the following fields:
            1.    hobby_name: The name of the hobby (e.g., Painting).
            2.    budget: The estimated budget for learning this hobby.
            3.    language: The language in which the plan is written.
            4.    learning_motivation: The reason for learning this hobby, based on the provided input.
            5.    learning_level: The starting level of the learner (e.g., Beginner, Intermediate, Advanced).
            5.    total_duration: The courses total duration.
            6.    plan: A detailed plan containing the following subfields:
            •    phases: A list of phases for learning this hobby. Each phase must include:
            •    duration: The expected time duration for the phase (e.g., “2 weeks”).
            •    goals: A list of goals to achieve during this phase.
            •    resources: A list of resources to be used (e.g., books, websites, tools).
            •    description: A brief description of what this phase entails.
        """
        print(self.prompt)
    }
    
    
    
    func createHobbyPlan() async  {
        let geminiManager = GeminiApiManager()
        
        createPrompt()
        
        
        do {
            self.progress = true
            // Gemini'den JSON yanıtını al
            try await geminiManager.generateTextToText(prompt: prompt)
  
          
            
            // Gemini'den gelen sonucu kontrol et
            if geminiManager.result.isEmpty {
                showError = true
                errorMessage = LocalKeys.CreateHobbyViewErrorCode.failedToGenerateHobbyPlan.rawValue.locale()
                self.progress = false
                
            }
            
            print("\(geminiManager.result)")
            
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
                return
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
            
            
        } catch {
            
        }
    }
    
    private let prohibitedKeywords: Set<String> = [
        // İngilizce Yasaklı Kelimeler
        "sex", "porn", "erotic", "nude", "escort", "strip", "fetish", "bdsm", "hardcore",
        "adult", "nsfw", "xxx", "taboo", "hentai", "camgirl", "cam", "swinger", "orgy",
        "dominatrix", "sado", "maso", "sugar daddy", "sugar baby", "playboy", "naked", "lingerie",
        
        // Türkçe Yasaklı Kelimeler
        "aşk", "pornografi", "erotik", "çıplak", "escort", "fetiş", "bdsm", "hardcore", "yetişkin",
        "nsfw", "yasaklı", "şeker baba", "şeker kız", "playboy", "çırılçıplak", "iç çamaşırı", "sikiş",
        "porno", "fahişe", "kucaklama", "çiftleşme", "seks", "mastürbasyon", "vücut", "peşin", "kucak",
        "hard", "adult", "rapist", "molestation", "orgasm", "climax", "violation", "abuse", "lick", "blowjob"
    ]

    private func containsProhibitedContent(_ input: String) -> Bool {
        let lowercasedInput = input.lowercased()
        
        // 1. Tam Eşleşme Kontrolü
        if prohibitedKeywords.contains(lowercasedInput) {
            return true
        }
        
        // 2. Yasaklı Kelime İçerik Kontrolü
        for keyword in prohibitedKeywords {
            if lowercasedInput.contains(keyword) {
                return true
            }
        }
        
        // 3. Yazım Hataları ve Benzerlik Kontrolü (Levenshtein Mesafesi)
        return isAdultContent(lowercasedInput)
    }

    /// Levenshtein Mesafesi ile Benzerlik Kontrolü
    private func isAdultContent(_ input: String) -> Bool {
        for keyword in prohibitedKeywords {
            // 0'a kadar benzerlik kontrolü yapıyoruz. Yani kelimeler tamamen eşleşmelidir.
            if levenshteinDistance(input, keyword) <= 0 {
                return true
            }
        }
        return false
    }

    /// Levenshtein Mesafesi Hesaplama
    private func levenshteinDistance(_ a: String, _ b: String) -> Int {
        let aCount = a.count
        let bCount = b.count
        
        guard aCount != 0, bCount != 0 else { return max(aCount, bCount) }
        
        var matrix = Array(repeating: Array(repeating: 0, count: bCount + 1), count: aCount + 1)
        
        for i in 0...aCount { matrix[i][0] = i }
        for j in 0...bCount { matrix[0][j] = j }
        
        for i in 1...aCount {
            for j in 1...bCount {
                let cost = a[a.index(a.startIndex, offsetBy: i - 1)] == b[b.index(b.startIndex, offsetBy: j - 1)] ? 0 : 1
                matrix[i][j] = min(matrix[i - 1][j] + 1, min(matrix[i][j - 1] + 1, matrix[i - 1][j - 1] + cost))
            }
        }
        
        return matrix[aCount][bCount]
    }

    /// RegEx kullanarak özel karakterleri tespit etme
    private func containsSpecialCharacters(_ input: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9\\s]", options: .caseInsensitive)
        let range = NSRange(location: 0, length: input.utf16.count)
        return regex.firstMatch(in: input, options: [], range: range) != nil
    }

    /// Gelişmiş analiz: Kelimelerin kökünü bulma
    private func containsRootWords(_ input: String) -> Bool {
        // Bu örnekte basit bir kök kelime analizi yaptık. Daha karmaşık bir çözüm için NLP kullanılabilir.
        let rootWords: Set<String> = ["porno", "seks", "fetiş", "hardcore", "mastürbasyon"]
        let lowercasedInput = input.lowercased()
        
        for word in rootWords {
            if lowercasedInput.contains(word) {
                return true
            }
        }
        return false
    }

    /// Ana içerik kontrolü: Hem yazım hatalarını hem özel karakterleri kontrol etme
    private func validateInput(_ input: String) -> Bool {
        if containsProhibitedContent(input) || containsSpecialCharacters(input) || containsRootWords(input) {
            return false
        }
        return true
    }
}



