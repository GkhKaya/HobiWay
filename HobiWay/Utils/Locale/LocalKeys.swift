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
        case createYourFirstHobbyPlan = "createYourFirstHobbyPlan"
        case welcomeBack = "welcomeBack"
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
    
    enum CreateHobbyCardView: String{
        case chooseTheBudgetYouCanUseForThisHobby = "chooseTheBudgetYouCanUseForThisHobby"
        case pleaseEnterTheHobbyYouWant = "pleaseEnterTheHobbyYouWant"
        case lowBudget = "lowBudget"
        case lowBudgetDesc = "lowBudgetDesc"
        case mediumBudget = "mediumBudget"
        case mediumBudgetDesc = "mediumBudgetDesc"
        case highBudget = "highBudget"
        case highBudgetDesc = "highBudgetDesc"
        case pleaseSelectRoadmapLanguage = "pleaseSelectRoadmapLanguage"
        case activeLanguages = "activeLanguages"
        case selectLevel = "selectLevel"
        case beginnerLevel = "beginnerLevel"
        case intermediateLevel = "intermediateLevel"
        case advancedLevel = "advancedLevel"
        case beginnerLevelDesc = "beginnerLevelDesc"
        case intermediateLevelDesc = "intermediateLevelDesc"
        case advancedLevelDesc = "advancedLevelDesc"
        case pleaseChooseTheMinutesYouCanSparePerDay = "pleaseChooseTheMinutesYouCanSparePerDay"
        case minute15 = "minute15"
        case minute15Desc = "minute15Desc"
        case minute30 = "minute30"
        case minute30Desc = "minute30Desc"
        case minute60 = "minute60"
        case minute60Desc = "minute60Desc"
    
    }
    
    
    
}
extension String{
    /// It localize any string from Localizable string
    /// - Returns: localized value
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
