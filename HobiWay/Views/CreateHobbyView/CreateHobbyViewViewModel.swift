//
//  CreateHobbyViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/5/24.
//

import SwiftUI


final class CreateHobbyViewViewModel: ObservableObject {
    @Published var hobbyName: String = ""
    @Published var selectedLanguage : String = ""
    @Published var selectedBudget : String? = nil
    @Published var selectedLevel : String? = nil
    @Published var selectedMunite : Int? = nil
    @Published var explaneWhyText : String = ""
    @Published var prompt : String?
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    
    
    func validateInputs(step: Int) {
           switch step {
           case 0:
               if hobbyName.isEmpty {
                   errorMessage = AppErrorCode.emptyField(fieldName: "Hobby Name").localizedDescription
                   showError = true
                
               }
           case 1:
               if selectedBudget == nil {
                   errorMessage = AppErrorCode.emptyField(fieldName: "Budget").localizedDescription
                   showError = true
                 
               }
           case 2:
               if selectedLanguage.isEmpty {
                   errorMessage = AppErrorCode.emptyField(fieldName: "Language").localizedDescription
                   showError = true
               }
           case 3:
               if selectedLevel == nil {
                   errorMessage = AppErrorCode.emptyField(fieldName: "Level").localizedDescription
                   showError = true
               }
           case 4:
               if selectedMunite == nil {
                   errorMessage = AppErrorCode.emptyField(fieldName: "Minutes").localizedDescription
                   showError = true
               }
           case 5:
               if explaneWhyText.isEmpty {
                   errorMessage = AppErrorCode.emptyField(fieldName: "Reason").localizedDescription
                   showError = true
               }
           default:
               break
           }
        
          
       }
    
    func createPrompt() -> String? {
          guard !hobbyName.isEmpty,
                !selectedLanguage.isEmpty,
                let budget = selectedBudget, !budget.isEmpty,
                let level = selectedLevel, !level.isEmpty,
                let munite = selectedMunite, munite % 5 == 0,
                !explaneWhyText.isEmpty else {
              return nil
          }

          prompt = "Hobby Name: " + hobbyName + "\n" + "Selected Language: " + selectedLanguage + "\n" + "Selected Budget: " + budget + "\n" + "Selected Level: " + level + "\n" + "Selected Minute: "  + "\(selectedMunite!)" + "\n" + "Why You Want to Learn This Hobby : " + explaneWhyText + "\n" + "Please create a hobby roadmap according to these information. Output can be json format."

          return prompt
      }
}
