//
//  HobbyDetailInfoCard.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 1/14/25.
//

import Foundation
import SwiftUI

struct InfoCard: View {
    let icon: String
    let title: LocalizedStringKey
    let value: String
    
    var body: some View {
        VStack(spacing: ProjectPaddings.medium.rawValue) {
            Image(systemName: icon)
                .foregroundColor(.safetyOrange)
                .modifier(Px24Regular())
                
            
            Text(title)
                .foregroundStyle(.gray)
                .modifier(Px12Regular())
            
            Text((value.prefix(1).uppercased() + value.dropFirst()))
                .foregroundStyle(.winterHaven)
                .modifier(Px14Regular())
                .multilineTextAlignment(.center)
                        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: ProjectRadius.small.rawValue)
                .fill(Color.libertyBlue)
                .shadow(color: Color.black.opacity(0.1), radius: 5)
        )
    }
}

struct PhaseCard: View {
    let phase: HobbyModel.Phase
    let phaseNumber: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: ProjectPaddings.medium.rawValue) {
            HStack {
                Text(LocalKeys.HobbyDetailView.phease.rawValue.locale())
                    .foregroundColor(.safetyOrange)
                    .modifier(Px18Bold())
                Text("\(phaseNumber)")
                    .foregroundColor(.safetyOrange)
                    .modifier(Px18Bold())
                
                Spacer()
                
                if let duration = phase.duration {
                    Text(duration)
                        .foregroundColor(.gray)
                        .modifier(Px12Light())
                }
            }
            
            // ScrollView ile sadece açıklamanın kaymasını sağlıyoruz
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: ProjectPaddings.medium.rawValue) {
                    if let description = phase.description {
                        Text(description)
                            .foregroundColor(.gray)
                            .modifier(Px14Regular())
                    }
                    
                    if let goals = phase.goals {
                        VStack(alignment: .leading, spacing: ProjectPaddings.small.rawValue) {
                            Text(LocalKeys.HobbyDetailView.goals.rawValue.locale())
                                .foregroundStyle(.winterHaven)
                                .modifier(Px12Bold())
                            
                            ForEach(goals, id: \.self) { goal in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .foregroundColor(.safetyOrange)
                                        .modifier(Px6Light())
                                    Text(goal)
                                        .foregroundStyle(.winterHaven)
                                        .modifier(Px14Regular())
                                }
                            }
                        }
                    }
                    
                    if let resources = phase.resources {
                        VStack(alignment: .leading, spacing: ProjectPaddings.small.rawValue) {
                            Text(LocalKeys.HobbyDetailView.resources.rawValue.locale())
                                .foregroundStyle(.winterHaven)
                                .modifier(Px12Bold())
                            
                            ForEach(resources, id: \.self) { resource in
                                HStack {
                                    Image(systemName: "link")
                                        .foregroundColor(.safetyOrange)
                                    Text(resource)
                                        .foregroundStyle(.winterHaven)
                                        .modifier(Px14Regular())
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                .fill(.libertyBlue)
                .shadow(color: Color.black.opacity(0.1), radius: ProjectRadius.extraSmall.rawValue)
        )
        .padding(.horizontal)
    }
}
