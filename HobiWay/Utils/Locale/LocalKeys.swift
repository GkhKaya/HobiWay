//
//  LocalKeys.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 5.10.2024.
//

import Foundation
import SwiftUI

struct LocalKeys{
    
    enum General : String{
        case email = "email"
        case password = "password"
    }
    
    enum Auth : String{
        case hereYouCanLearnAnyHobbyYouWant = "hereYouCanLearnAnyHobbyYouWant"
        case learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills = "learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills"
        case signIn = "signIn"
        case signUp = "signUp"
        case welcomeBack = "welcomeBack"
        case pleaseEnterYourDetailsToContinueLearningAboutYourHobbies = "pleaseEnterYourDetailsToContinueLearningAboutYourHobbies"
        case rememberMe = "rememberMe"
        case forgotPassword = "forgotPassword"
        case signInWithApple = "signInWithApple"
        case signInWithGoogle = "signInWithGoogle"
        case signUpWithApple = "signUpWithApple"
        case signUpWithGoogle = "signUpWithGoogle"
    }
}
extension String{
    /// It localize any string from Localizable string
    /// - Returns: localized value
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
