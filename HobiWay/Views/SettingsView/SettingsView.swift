import SwiftUI

struct SettingsView: View {
    @StateObject private var vm = SettingsViewViewModel()
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                if vm.isLoading {
                    ProgressView()
                        .modifier(ProgressModifier())
                } else {
                    ScrollView {
                        VStack(spacing: UIScreen.main.bounds.height * 0.03) {
                            // User Info Card
                            VStack(spacing: UIScreen.main.bounds.height * 0.02) {
                                Circle()
                                    .fill(Color.safetyOrange)
                                    .frame(
                                        width: UIScreen.main.bounds.width * 0.2,
                                        height: UIScreen.main.bounds.width * 0.2
                                    )
                                    .overlay(
                                        Text(vm.userData?.fullName.prefix(1).uppercased() ?? "")
                                            .modifier(Px24Bold())
                                            .foregroundColor(.white)
                                    )
                                
                                VStack(spacing: 8) {
                                    Text(vm.userData?.fullName ?? "")
                                        .modifier(Px18Bold())
                                        .foregroundColor(.white)
                                    
                                    Text(vm.userData?.mail ?? "")
                                        .modifier(Px16Regular())
                                        .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(UIScreen.main.bounds.width * 0.06)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.safetyOrange)
                                    .shadow(radius: 10)
                            )
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
                            
                            // Stats Grid
                            LazyVGrid(
                                columns: [
                                    GridItem(.flexible(), spacing: UIScreen.main.bounds.width * 0.04),
                                    GridItem(.flexible(), spacing: UIScreen.main.bounds.width * 0.04),
                                    GridItem(.flexible(), spacing: UIScreen.main.bounds.width * 0.04)
                                ],
                                spacing: UIScreen.main.bounds.height * 0.02
                            ) {
                                StatCard(
                                    title: "Hobbies",
                                    value: "\(vm.totalHobbies)",
                                    icon: "star.fill"
                                )
                                
                                StatCard(
                                    title: "Gender",
                                    value: vm.getGenderString(),
                                    icon: "person.fill"
                                )
                                
                                StatCard(
                                    title: "Age",
                                    value: "\(vm.userData?.age ?? 0)",
                                    icon: "calendar"
                                )
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
                            
                            // Account Section
                            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.02) {
                                Text("Account")
                                    .modifier(Px18Bold())
                                
                                Button(action: {}) {
                                    NavigationLink(destination: UpdateEmailView()) {
                                        SettingsButton(title: "Change Email", icon: "envelope.fill")
                                    }
                                }
                                
                                Button(action: {}) {
                                    NavigationLink(destination: UpdatePasswordView()) {
                                        SettingsButton(title: "Change Password", icon: "key.fill")
                                    }
                                }
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
                            
                            // App Section
                            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.02) {
                                Text("App")
                                    .modifier(Px18Bold())
                                
                                SettingsButton(
                                    title: "Dark Mode",
                                    icon: "moon.fill",
                                    hasToggle: true,
                                    isToggled: $isDarkMode
                                )
                            }
                            .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
                        }
                        .padding(.vertical, UIScreen.main.bounds.width * 0.04)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .task {
            try? await vm.fetchUserData()
        }
    }
}

struct SettingsButton: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let icon: String
    var hasToggle: Bool = false
    var isToggled: Binding<Bool>? = nil
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.safetyOrange)
                .font(.system(size: UIScreen.main.bounds.width * 0.05))
            Text(title)
                .modifier(Px16Regular())
            Spacer()
            
            if hasToggle, let isToggled = isToggled {
                Toggle("", isOn: isToggled)
                    .tint(.safetyOrange)
                    .labelsHidden()
            }
        }
        .padding(.vertical, UIScreen.main.bounds.height * 0.02)
        .padding(.horizontal, UIScreen.main.bounds.width * 0.04)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct StatCard: View {
    @Environment(\.colorScheme) var colorScheme
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: UIScreen.main.bounds.height * 0.015) {
            Image(systemName: icon)
                .font(.system(size: UIScreen.main.bounds.width * 0.06))
                .foregroundColor(.safetyOrange)
            
            Text(title)
                .modifier(Px12Regular())
                .foregroundColor(colorScheme == .dark ? .gray : .gray)
            
            Text(value)
                .modifier(Px16Bold())
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, UIScreen.main.bounds.height * 0.02)
        .padding(.horizontal, UIScreen.main.bounds.width * 0.03)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? Color.black : Color.white)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 5)
        )
    }
} 