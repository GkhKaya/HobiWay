import SwiftUI

struct HobbyDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var vm: HobbyDetailViewViewModel
    @State private var selectedPhase: Int = 0
    
    init(hobby: HobbyModel) {
        self.vm = HobbyDetailViewViewModel(hobby: hobby)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        VStack(spacing: 16) {
                            Text(vm.hobby.hobbyName)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                            
                            if vm.totalGoals > 0 {
                                Text("\(vm.totalGoals) Goals to Achieve")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                            }
                        }
                        .padding(24)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.safetyOrange)
                                .shadow(radius: 10)
                        )
                        .padding(.horizontal)
                        
                        // Info Cards
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            InfoCard(icon: "graduationcap.fill", title: "Level", value: vm.hobby.learningLevel)
                            InfoCard(icon: "translate", title: "Language", value: vm.hobby.language)
                            InfoCard(icon: "wallet.bifold.fill", title: "Budget", value: vm.hobby.budget)
                            InfoCard(icon: "clock.fill", title: "Duration", value: vm.hobby.totalDuration ?? "Not set")
                        }
                        .padding(.horizontal)
                        
                        // Phases
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Learning Journey")
                                    .font(.title2)
                                    .bold()
                                
                                Spacer()
                                
                                // Kaydırma ipucu
                                HStack(spacing: 4) {
                                    Image(systemName: "hand.draw.fill")
                                        .foregroundColor(.gray)
                                    Text("Swipe")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                            
                            TabView(selection: $selectedPhase) {
                                ForEach(Array(vm.hobby.plan.phases.enumerated()), id: \.offset) { index, phase in
                                    PhaseCard(phase: phase, phaseNumber: index + 1)
                                        .tag(index)
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 400)
                            
                            // Sayfa indikatörü
                            HStack {
                                ForEach(0..<vm.hobby.plan.phases.count, id: \.self) { index in
                                    Circle()
                                        .fill(index == selectedPhase ? Color.safetyOrange : Color.gray.opacity(0.3))
                                        .frame(width: 8, height: 8)
                                        .animation(.easeInOut, value: selectedPhase)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.libertyBlue)
                    }
                }
            }
        }
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(.safetyOrange)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct PhaseCard: View {
    let phase: HobbyModel.Phase
    let phaseNumber: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Phase \(phaseNumber)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.safetyOrange)
                
                Spacer()
                
                if let duration = phase.duration {
                    Text(duration)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            if let description = phase.description {
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            if let goals = phase.goals {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Goals")
                        .font(.headline)
                    
                    ForEach(goals, id: \.self) { goal in
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundColor(.safetyOrange)
                            Text(goal)
                                .font(.subheadline)
                        }
                    }
                }
            }
            
            if let resources = phase.resources {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Resources")
                        .font(.headline)
                    
                    ForEach(resources, id: \.self) { resource in
                        HStack {
                            Image(systemName: "link")
                                .foregroundColor(.safetyOrange)
                            Text(resource)
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10)
        )
        .padding(.horizontal)
    }
} 
