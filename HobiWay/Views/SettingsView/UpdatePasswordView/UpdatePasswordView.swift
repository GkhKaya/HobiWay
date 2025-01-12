import SwiftUI

struct UpdatePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = UpdatePasswordViewViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    SecureFieldWidget(
                        iconName: "lock.fill",
                        text: $vm.currentPassword
                    )
                    
                    SecureFieldWidget(
                        iconName: "lock.fill",
                        text: $vm.newPassword
                    )
                    
                    Button {
                        Task {
                            await vm.updatePassword()
                        }
                    } label: {
                        if vm.isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Update Password")
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
            .navigationTitle("Update Password")
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
            .onChange(of: vm.isSuccess) { oldValue, newValue in
                if newValue {
                    dismiss()
                }
            }
        }
    }
} 
