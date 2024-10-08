//
//  AuthRootView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 7.10.2024.
//

import SwiftUI

struct AuthRootView: View {
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                ZStack{
                    Color.winterHaven.ignoresSafeArea()
                    
                    VStack{
                        Image(ProjectImages.AuthImages.imgAuth.rawValue)
                            .resizable()
                            .frame(width: geometry.dw(width: 0.6),height: geometry.dh(height: 0.4))
                        
                        Text(LocalKeys.Auth.hereYouCanLearnAnyHobbyYouWant.rawValue.locale())
                            .modifier(Px24Bold())
                            .multilineTextAlignment(.center)
                        
                        
                        Text(LocalKeys.Auth.learningANewHobbyIsAFantasticJourneyToAddColorToYourLifeAndGainNewSkills.rawValue.locale())
                            .modifier(Px18Regular())
                            .multilineTextAlignment(.center).padding(.top,ProjectPaddings.normal.rawValue)
                        
                        HStack{
                            NavigationLink(destination: AuthSignUpView()){
                                
                                Text(LocalKeys.Auth.signUp.rawValue.locale())
                                    .foregroundStyle(.white)
                                    .modifier(Px16Bold())
                                    .padding()
                                    .padding(.horizontal,ProjectPaddings.normal.rawValue)                                        .background(Color.safetyOrange)
                                    .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                                
                                
                            }.padding(.trailing,ProjectPaddings.normal.rawValue)
                            
                            NavigationLink(destination: AuthSignInView()){
                                Text(LocalKeys.Auth.signIn.rawValue.locale())
                                
                                    .modifier(Px16Bold())
                                    .padding()
                                    .padding(.horizontal,ProjectPaddings.normal.rawValue)
                                    .background(
                                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                                            .fill(Color.clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                                            .stroke(Color.safetyOrange, lineWidth: 2)                                         )
                                
                                
                            }
                        }.padding(.top)
                        
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    AuthRootView()
}
