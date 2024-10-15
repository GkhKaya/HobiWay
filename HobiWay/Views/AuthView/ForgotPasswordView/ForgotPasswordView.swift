//
//  ForgotPasswordView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 15.10.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject private var vm = ForgotPasswordViewViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var allertSuccesMessage : LocalizedStringKey?
    @State private var successAlert = false // Başarı durumu için yeni state
    
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
                        do {
                            try await vm.resetpAssword()
                            alertMessage = LocalKeys.Auth.sendedMail.rawValue
                            successAlert = true
                        } catch {
                            alertMessage = error.localizedDescription
                            showAlert = true
                        }
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
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .alert(isPresented: $successAlert) {
                    Alert(title: Text("Success"), message: Text(alertMessage.locale()), dismissButton: .default(Text("OK")))
                }
            }.padding()
        }
    }
}

#Preview {
    ForgotPasswordView()
}
