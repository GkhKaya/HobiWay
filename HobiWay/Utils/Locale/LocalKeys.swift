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
        case fullName = "fullName"
    }
    
    enum Auth : String{
        case hereYouCanLearnAnyHobbyYouWant = "hereYouCanLearnAnyHobbyYouWant"
        case learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills = "learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills"
        case signIn = "signIn"
        case signUp = "signUp"
        case welcomeBack = "welcomeBack"
        case joinUs = "joinUs"
        case pleaseEnterYourDetailsToContinueLearningAboutYourHobbies = "pleaseEnterYourDetailsToContinueLearningAboutYourHobbies"
        case sendedMail = "sendedMail"
        case rememberMe = "rememberMe"
        case forgotPassword = "forgotPassword"
        case signInWithApple = "signInWithApple"
        case signInWithGoogle = "signInWithGoogle"
        case signUpWithApple = "signUpWithApple"
        case signUpWithGoogle = "signUpWithGoogle"
        case ifYouDontHaveAnAccount = "ifYouDontHaveAnAccount"
        case ifYouHaveAnAccount = "ifYouHaveAnAccount"
        case pleaseEnterEmail = "pleaseEnterEmail"
    }
}
extension String{
    /// It localize any string from Localizable string
    /// - Returns: localized value
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
