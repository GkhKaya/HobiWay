//
//  HobbyCard.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 3.11.2024.
//

import SwiftUI

struct HobbyCard: View {
    let hobby: HobbyModel
    
    // Toplam süreyi hesaplayan computed property
   
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                Text(hobby.hobbyName)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .background(Color.safetyOrange)
            
            // Content
            VStack {
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "graduationcap.fill")
                            .foregroundColor(.gray)
                        Text(hobby.learningLevel)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "translate")
                            .foregroundColor(.gray)
                        Text(hobby.language)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                }
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "wallet.bifold.fill")
                            .foregroundColor(.gray)
                        Text(hobby.budget)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gray)
                        Text(hobby.totalDuration ?? "")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
        }
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding()
    }
}
