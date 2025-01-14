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
                    VStack(spacing: ProjectPaddings.extraLarge.rawValue) {
                        
                        HobbyHeaderView(hobbyName: vm.hobby.hobbyName, totalGoals: vm.totalGoals)
                        
                        InfoSection(learningLevel: vm.hobby.learningLevel, language: vm.hobby.language, budget: vm.hobby.budget,duration: vm.hobby.totalDuration)
                        
                        g
                        
                        // Phases
                        VStack(
                            alignment: .leading,
                            spacing: ProjectPaddings.normal.rawValue
                        ) {
                            HStack {
                                Text(
                                    LocalKeys.HobbyDetailView.learningJourney
                                        .rawValue.locale()
                                )
                                .font(.title2)
                                .bold()
                                
                                Spacer()
                                
                                // Kaydırma ipucu
                                HStack(
                                    spacing: ProjectPaddings.extraSmall.rawValue
                                ) {
                                    Image(systemName: "hand.draw.fill")
                                        .foregroundColor(.gray)
                                    Text(
                                        LocalKeys.HobbyDetailView.swipe.rawValue
                                            .locale()
                                    )
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                }
                            }
                            .padding(.horizontal)
                            
                            TabView(selection: $selectedPhase) {
                                ForEach(
                                    Array(vm.hobby.plan.phases.enumerated()),
                                    id: \.offset
                                ) { index, phase in
                                    PhaseCard(
                                        phase: phase, phaseNumber: index + 1
                                    )
                                    .tag(index)
                                }
                            }
                            .tabViewStyle(.page)
                            .frame(height: 400)
                            
                            // Sayfa indikatörü
                            HStack {
                                ForEach(
                                    0..<vm.hobby.plan.phases.count, id: \.self
                                ) { index in
                                    Circle()
                                        .fill(
                                            index == selectedPhase
                                            ? Color.safetyOrange
                                            : Color.gray.opacity(0.3)
                                        )
                                        .frame(width: 8, height: 8)
                                        .animation(
                                            .easeInOut, value: selectedPhase)
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




struct HobbyHeaderView: View {
    var hobbyName: String
    var totalGoals: Int
    var body: some View {
        
        VStack(spacing: ProjectPaddings.normal.rawValue) {
            Text(hobbyName)
                .foregroundStyle(.winterHaven)
                .modifier(Px32Bold())
                .padding(
                    .horizontal,
                    ProjectPaddings.extraLarge.rawValue
                )
                .multilineTextAlignment(.center)
            
            if totalGoals > 0 {
                HStack {
                    Text("\(totalGoals)")
                        .foregroundColor(.winterHaven)
                        .modifier(Px12Light())
                        .padding(.trailing,-5)
                    
                    
                    Text(LocalKeys.HobbyDetailView.goalsToAchive.rawValue.locale())
                        .foregroundColor(.winterHaven)
                        .modifier(Px12Light())
                }
                
            }
        }
        .padding(ProjectPaddings.large.rawValue)
        .background(
            RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                .fill(Color.safetyOrange)
                .shadow(radius: ProjectRadius.small.rawValue)
        )
        .padding(.horizontal)
    }
}

struct InfoSection : View {
    var learningLevel: String
    var language : String
    var budget : String
    var duration : String?
    var body: some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ], spacing: ProjectPaddings.medium.rawValue
        ) {
            InfoCard(
                icon: "graduationcap.fill",
                title: LocalKeys.HobbyDetailView.level.rawValue
                    .locale(), value: learningLevel)
            InfoCard(
                icon: "translate",
                title: LocalKeys.HobbyDetailView.languge
                    .rawValue.locale(), value: language
            )
            InfoCard(
                icon: "wallet.bifold.fill",
                title: LocalKeys.HobbyDetailView.budget.rawValue
                    .locale(), value: budget)
            InfoCard(
                icon: "clock.fill",
                title: LocalKeys.HobbyDetailView.duration
                    .rawValue.locale(),
                value: duration ?? "Not set")
        }
        .padding(.horizontal)
    }
}
