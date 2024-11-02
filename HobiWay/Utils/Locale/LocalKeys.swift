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
        case phoneNumber = "phoneNumber"
        case fullName = "fullName"
        case next = "next"
        case hello = "hello"
        case age = "age"
        case gender = "gender"
        case finish = "finish"
        case alert = "alert"
        case okay = "okay"
        case man = "man"
        case woman = "woman"
        case other = "other"
    }
    
    enum HomeView : String{
        case theBestAppForLearnDreamHooby = "theBestAppForLearnDreamHooby"
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
    
enum InformationView : String{
    case letsGetToNowYouALittleBit = "letsGetToNowYouALittleBit"
    case firstLetsLearnYourName = "firstLetsLearnYourName"
    case weAreHobiWayDevelopmentTeam = "weAreHobiWayDevelopmentTeam"
    case youCanReachUsAnytimeAtHobiwaycontactdevosuitcom = "youCanReachUsAnytimeAtHobiwaycontact@devosuit.com"
    case nowLetsKnowYourAgeAndGender = "nowLetsKnowYourAgeAndGender"
    case nextIsYourpPhoneNumber = "nextIsYourpPhoneNumber"
    case finallyTellUsALittleAboutYourself = "finallyTellUsALittleAboutYourself"
    case pleaseSelectYouInterest = "pleaseSelectYouInterest"
}
    
    enum InformationViewError : String{
        case pleaseEnterYourName = "pleaseEnterYourName"
        case pleaseEnterYourPhoneNumber = "pleaseEnterYourPhoneNumber"
        case pleaseSelectLeastTwoInterest = "pleaseSelectLeastTwoInterest"
        case pleaseEnterLeast100Characters = "pleaseEnterLeast100Characters"
    }
}
extension String{
    /// It localize any string from Localizable string
    /// - Returns: localized value
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
