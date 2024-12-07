//
//  HomeView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 14.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var isFirstSignIn: Bool = false
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                ZStack{
                    Color.winterHaven.ignoresSafeArea()
                    
                    VStack{
                        HStack {
                            VStack {
                                Text(LocalKeys.HomeView.welcomeBack.rawValue.locale())
                                    .modifier(Px16Light())
                                
                                Text("Gökhan Kaya")
                                    .modifier(Px18Bold())
                            }
                            
                          
                            Spacer()

                            
                            Button {
                                
                            }label: {
                                Image(systemName: "bell")
                                    .resizable()
                                    .frame(width: geometry.dw(width: 0.07),height: geometry.dh(height: 0.035))
                                    .foregroundStyle(.libertyBlue)
                            }
                                
                            
                            
                            
                        }
                        Spacer()
                        
                        Text(LocalKeys.HomeView.createYourFirstHobbyPlan.rawValue.locale())
                            .modifier(Px24Bold())
                   
                        
                        
                        Spacer()
                    }.padding()
                    
                   
                }
            }
        }
    }
}


#Preview {
    HomeView()
}
