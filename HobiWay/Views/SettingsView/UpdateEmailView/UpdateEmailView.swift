import SwiftUI

struct UpdateEmailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var vm = UpdateEmailViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                VStack(spacing: ProjectPaddings.large.rawValue) {
                    // Yeni Email Alanı
                    TextFieldWidget(
                        title: LocalKeys.SettingsView.newemail.rawValue.locale(),
                        iconName: "envelope.fill",
                        text: $vm.newEmail
                    )
                    
                    // Mevcut Şifre Alanı
                    SecureFieldWidget(iconName: "lock", text: $vm.currentPassword, placeHolderText: LocalKeys.SettingsView.currentPassword.rawValue.locale())

                    // Güncelleme Butonu
                    Button {
                        Task {
                            await vm.updateEmail()
                        }
                    } label: {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text(LocalKeys.SettingsView.updateemail.rawValue.locale())
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
                    .disabled(vm.isLoading || vm.newEmail.isEmpty || vm.currentPassword.isEmpty)
                }
                .padding()
            }
            .navigationTitle(LocalKeys.SettingsView.updateemail.rawValue.locale())
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
