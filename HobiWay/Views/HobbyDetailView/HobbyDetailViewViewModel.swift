import Foundation

@MainActor
final class HobbyDetailViewViewModel: ObservableObject {
    @Published var hobby: HobbyModel
    
    init(hobby: HobbyModel) {
        self.hobby = hobby
    }
    
    // Toplam goal sayısını hesapla
    var totalGoals: Int {
        hobby.plan.phases.compactMap { $0.goals }.flatMap { $0 }.count
    }
} 
