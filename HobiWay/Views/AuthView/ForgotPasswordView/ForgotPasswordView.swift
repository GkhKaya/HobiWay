//
//  ForgotPasswordView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 15.10.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject private var vm = ForgotPasswordViewViewModel()

    @State private var allertSuccesMessage : LocalizedStringKey?
    @State private var successAlert = false
    
    var body: some View {
        ZStack {
            Color.winterHaven.ignoresSafeArea()
            VStack {
                Text(LocalKeys.Auth.forgotPassword.rawValue.locale())
                    .modifier(Px18Bold())
                Text(LocalKeys.Auth.pleaseEnterEmail.rawValue.locale())
                    .modifier(Px16Regular())
                
                
                TextFieldWidget(title: LocalKeys.General.email.rawValue.locale(), iconName: "envelope.fill", text: $vm.email)
                    .padding(.top,ProjectPaddings.normal.rawValue)
                
                
                Button{
                    Task{
               
                            try await vm.resetpAssword()
                        allertSuccesMessage = LocalKeys.Auth.sendedMail.rawValue.locale()
                            successAlert = true
                       
                    }
                }label:{
                    Text(LocalKeys.Auth.forgotPassword.rawValue.locale())
                        .foregroundStyle(.white)
                        .modifier(Px16Bold())
                }
                .padding()
                .padding(.horizontal,ProjectPaddings.large.rawValue)
                .background(.safetyOrange)
                .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                .padding(.top,ProjectPaddings.normal.rawValue)
                .alert(isPresented: $vm.showAlert) {
                    Alert(title: Text("Error"), message: Text(vm.errorMessage), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $vm.successAlert) { 
                    Alert(title: Text("Success"), message: Text(vm.allertSuccesMessage ?? ""), dismissButton: .default(Text("OK")))
                }
            }.padding()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
