//
//  AuthSignUpViewViewModel.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 7.10.2024.
//

import Foundation

final class AuthSignUpViewViewModel : ObservableObject{
    @Published var email: String = ""
    @Published var userName: String = ""
    @Published var password: String = ""
}
