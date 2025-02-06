import SwiftUI

import SwiftUI

struct UpdatePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = UpdatePasswordViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                VStack(spacing: ProjectPaddings.large.rawValue) {
                    // Mevcut Şifre Alanı
                    SecureFieldWidget(
                        iconName: "lock.fill",
                        text: $vm.currentPassword,
                        placeHolderText: LocalKeys.SettingsView.currentPassword.rawValue.locale()
                    )
                    
                    // Yeni Şifre Alanı
                    SecureFieldWidget(
                        iconName: "lock.fill",
                        text: $vm.newPassword,
                        placeHolderText: LocalKeys.SettingsView.newPassword.rawValue.locale()
                    )
                    
                    // Güncelleme Butonu
                    Button {
                        Task {
                            await vm.updatePassword()
                        }
                    } label: {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text(LocalKeys.SettingsView.updatePassword.rawValue.locale())
                                .modifier(Px16Bold())
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.safetyOrange)
                    )
                    .disabled(vm.isLoading)
                }
                .padding()
            }
            .navigationTitle(LocalKeys.SettingsView.updatePassword.rawValue.locale())
            .navigationBarTitleDisplayMode(.inline)
           
            .alert(LocalKeys.General.error.rawValue.locale(), isPresented: $vm.showAlert) {
                Button(LocalKeys.General.okay.rawValue.locale(), role: .cancel) { }
            } message: {
                Text(vm.errorMessage)
            }
            
            // iOS 16 ve iOS 17 için uyumlu değişiklik izleme
            .onChange(of: vm.isSuccess) { newValue in
                if newValue {
                    dismiss()
                }
            }
            .onAppear {
                // iOS 16 için alternatif çözüm (iOS 17'de onChange çalışıyor)
                if vm.isSuccess {
                    dismiss()
                }
            }
        }
    }
}
