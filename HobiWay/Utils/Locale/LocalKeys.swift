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
        case tr = "tr"
        case eng = "eng"
        case error = "error"
        case hobbies = "hobbies"
        case account = "account"
        case success = "success"
        case yes = "yes"
        case no = "no"
        

    }
    
    
    enum GeneralError: String{
        case unknow = "unknow"
        
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
        case successfullySignedUp = "successfullySignedUp"
        case accountCreatedSuccessful = "accountCreatedSuccessful"
    }
    
    
    enum AuthErrorCode: String{
        case userNotFound = "userNotFound"
        case emailAlreadyInUse = "emailAlreadyInUse"
        case weakPassword = "weakPassword"
        case invalidMail = "invailEmail"
        case authFieldsEmpty = "authFieldsEmpty"
        case signInFailed = "signInFailed"
        case passwordResetFailed = "passwordResetFailed"
        case emailResetFailed = "emailResetFailed"
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
        case selectCountryCode = "selectCountryCode"
        case whatShouldToWriteAboutYourself = "whatToWriteAboutYourself"
        case educationAndMajor = "educationAndMajor"
        case hobbiesAndInterests = "hobbiesAndInterests"
        case favoriteBookMovieSeries = "favoriteBookMovieSeries"
        case lifeDreams = "lifeDreams"
        case careerAndJobInterests = "careerAndJobInterests"
        case travelExperiences = "travelExperiences"
        case specialSkills = "specialSkills"
        case inspirationalPeople = "inspirationalPeople"
        case dailyActivities = "dailyActivities"
        case lifePhilosophy = "lifePhilosophy"
        case idontwantspecify = "idontwantspecify"
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
        case explainWhyTexty = "explainWhyText"
        case generatingPlan = "generatingPlan"
    }
    
    enum CreateHobbyViewErrorCode: String{
        case hobbyNameRequired = "hobbyNameRequired"
        case budgetRequired = "budgetRequired"
        case languageRequired = "languageRequired"
        case levelRequired = "levelRequired"
        case resonRequired = "resonRequired"
        case muniteRequired = "muniteRequired"
        case pleaseFillAllRequiredFieldsCorrectly = "pleaseFillAllRequiredFieldsCorrectly"
        case failedToGenerateHobbyPlan = "failedToGenerateHobbyPlan"
        case createHobbyError = "createHobbyError"
        case adultContent = "adultContent"
    }
    
    enum HobbyDetailView : String{
        case level = "level"
        case languge = "languge"
        case budget = "budget"
        case duration = "duration"
        case learningJourney = "learningJourney"
        case swipe = "swipe"
        case goalsToAchive = "goalsToAchive"
        case goals = "goals"
        case resources = "resources"
        case phease = "phease"
    }
    
    enum SettingsView: String{
        case currentPassword = "currentPassword"
        case newPassword = "newPassword"
        case currentemail = "currentemail"
        case newemail = "newemail"
        case updatePassword = "updatePassword"
        case updateemail = "updateemail"
        case changeEmail = "changeEmail"
        case changePassword = "changePassword"
        case darkMode = "darkMode"
        case settings = "settings"
        case signOut = "signOut"
        case deleteAccount = "deleteAccount"
        case areYouSureForDeleteAccount = "areYouSureForDeleteAccount"
        
    }
    
    enum SettingsViewErrorCode: String{
        case passwordUpdateFailed = "passwordUpdateFailed"
        case emailUpdateFailed = "emailUpdateFailed"
        case yourCurrentPasswordIsWrong = "yourCurrentPasswordIsWrong"
        case yourCurrentEmailIsWrong = "yourCurrentEmailIsWrong"
    }

 

    
 
    
    
}
extension String{
    /// It localize any string from Localizable string
    /// - Returns: localized value
    func locale() -> LocalizedStringKey {
        return LocalizedStringKey(self)
    }
}
