//
//  HobbyCard.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 3.11.2024.
//

import SwiftUI

struct HobbyCard: View {
    var body: some View {
        VStack{
            GeometryReader{geometry in
                ZStack(alignment:.top){
                    ZStack {
                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                            .frame(height: geometry.dh(height: 0.25))
                            .foregroundStyle(.libertyBlue)
                        
                        VStack{
                            HStack{
                                Image(systemName: "person.fill")
                                    .foregroundStyle(.white)
                                Text("Gokhan Kaya")
                                    .foregroundStyle(.white)
                                    .modifier(Px16Bold())
                                
                                Spacer()
                                
                                Image(systemName: "clock.fill")
                                    .foregroundStyle(.white)
                                Text("8 Weeks")
                                    .foregroundStyle(.white)
                                    .modifier(Px16Bold())
                            }.padding()
                                .padding(.top,ProjectPaddings.extraLarge.rawValue)
                            
                            HStack{
                                Image(systemName: "document.fill")
                                    .foregroundStyle(.white)
                                Text("Music")
                                    .foregroundStyle(.white)
                                    .modifier(Px16Bold())
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.white)
                                
                            }.padding()
                        }
                    }
                    
                    ZStack{
                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                            .frame(height: geometry.dh(height: 0.075))
                            .foregroundStyle(.safetyOrange)
                        
                        Text("sasasasasa")
                            .foregroundStyle(.white)
                            .modifier(Px16Bold())
                    }
                    
                }.padding()
                
            }
        }
    }
}

#Preview {
    HobbyCard()
}
