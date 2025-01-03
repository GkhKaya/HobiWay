//
//  HobbyCard.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 3.11.2024.
//

import SwiftUI

struct CourseCardView: View {
    let courseTitle: String
    let weekCount: Int
    let language:String
    let budget:String
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Spacer()
                Text(courseTitle)
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
                        
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gray)
                        Text("\(weekCount) Weeks")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "translate")
                            .foregroundColor(.gray)
                        Text("\(language)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                }
              
                
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "wallet.bifold.fill")
                            .foregroundColor(.gray)
                        Text("\(budget)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.gray)
                        Text("\(weekCount) Weeks")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    .padding()
                }
            }  .frame(maxWidth: .infinity)
                .background(Color.white)
        }
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding()
    }
}

#Preview {
    CourseCardView(courseTitle: "sefa", weekCount: 2, language:"tr",budget: "low")
}
