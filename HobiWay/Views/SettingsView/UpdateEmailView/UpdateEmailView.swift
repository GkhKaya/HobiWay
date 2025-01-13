import SwiftUI

struct UpdateEmailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var vm = UpdateEmailViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Yeni Email Alanı
                    TextFieldWidget(
                        title: "New Email",
                        iconName: "envelope.fill",
                        text: $vm.newEmail
                    )
                    
                    // Mevcut Şifre Alanı
                    SecureFieldWidget(iconName: "lock", text: $vm.currentPassword)

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
                            Text("Update Email")
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
            .navigationTitle("Update Email")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.libertyBlue)
                    }
                }
            }
            .alert("Error", isPresented: $vm.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(vm.errorMessage)
            }
            .onChange(of: vm.isSuccess) { _, newValue in
                if newValue {
                    dismiss()
                }
            }
        }
    }
}
