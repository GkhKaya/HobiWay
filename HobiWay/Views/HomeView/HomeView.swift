//
//  HomeView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 14.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var isFirstSignIn: Bool = false
    @ObservedObject private var vm = HomeViewViewModel()
    var body: some View {
        NavigationStack{
            GeometryReader{geometry in
                ZStack{
                    Color.winterHaven.ignoresSafeArea()
                    
                    if vm.isLoading {
                        VStack {
                            ProgressView()
                                .modifier(ProgressModifier())
                        }
                    } else {
                        VStack{
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(LocalKeys.HomeView.welcomeBack.rawValue.locale())
                                        .modifier(Px16Light())
                                    
                                    Text(vm.userData?.fullName ?? "")
                                        .modifier(Px18Bold())
                                }
                                
                                Spacer()

                                
                               
                                
                                
                                
                            }
                            .padding()
                            
                            if vm.matchedHobbies.isEmpty {
                                VStack {
                                    Spacer()
                                    Text(LocalKeys.HomeView.createYourFirstHobbyPlan.rawValue.locale())
                                        .modifier(Px24Bold())
                                    Spacer()
                                }
                            } else {
                                ScrollView {
                                    LazyVStack {
                                        ForEach(vm.matchedHobbies) { hobby in
                                            NavigationLink(destination: HobbyDetailView(hobby: hobby)) {
                                                HobbyCard(hobby: hobby)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                        }.padding()
                    }
                }
            }.navigationBarBackButtonHidden()
        }.onAppear{
            Task{
                try await vm.fetchUserAndMatchedHobbies()
            }
        }
    }
}


#Preview {
    HomeView()
}
