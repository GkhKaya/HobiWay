
//
//  CreateHobbyView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 12/5/24.
//

import SwiftUI

struct CreateHobbyView: View {
    @ObservedObject private var vm = CreateHobbyViewViewModel()
    @State private var caseCounter: Int = 0
    
    @State private var output: String = ""
    
    var body: some View {
        ZStack {
            Color.winterHaven.ignoresSafeArea()
            
            ZStack {
                switch caseCounter {
                case 0:
                    VStack {
                        Text(LocalKeys.CreateHobbyCardView.pleaseEnterTheHobbyYouWant.rawValue.locale())
                            .modifier(Px18Bold())
                        
                        TextFieldWidget(title: "Hobby", iconName: "figure.walk", text: $vm.hobbyName)
                        
                        ButtonWithBg(action: {
                            vm.validateInputs(step: caseCounter)
                            if (!vm.showError) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    caseCounter += 1
                                }
                            }
                        }, title: LocalKeys.General.next.rawValue.locale())
                    }
                    .padding()
                    .transition(.move(edge: .leading).combined(with: .opacity))
                    
                case 1:
                    GeometryReader { geometry in
                        VStack {
                            Text(LocalKeys.CreateHobbyCardView.chooseTheBudgetYouCanUseForThisHobby.rawValue.locale())
                                .modifier(Px18Bold())
                            
                            VStack(spacing: ProjectPaddings.normal.rawValue) {
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.lowBudget.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.lowBudgetDesc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.lowBudget.rawValue,
                                    isSelected: .constant(vm.selectedBudget == "low"),
                                    action: {
                                        vm.selectedBudget = "low"
                                    }
                                )
                                
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.mediumBudget.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.mediumBudgetDesc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.mediumBudget.rawValue,
                                    isSelected: .constant(vm.selectedBudget == "medium"),
                                    action: {
                                        vm.selectedBudget = "medium"
                                    }
                                )
                                
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.highBudget.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.highBudgetDesc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.highBudget.rawValue,
                                    isSelected: .constant(vm.selectedBudget == "high"),
                                    action: {
                                        vm.selectedBudget = "high"
                                    }
                                )
                            }
                            .padding(.top, ProjectPaddings.huge.rawValue)
                            
                            ButtonWithBg(action: {
                                vm.validateInputs(step: caseCounter)
                                if (!vm.showError) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        caseCounter += 1
                                    }
                                }
                            }, title: LocalKeys.General.next.rawValue.locale())
                        }
                        .padding()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                case 2:
                    GeometryReader{geometry in
                        VStack(alignment: .center){
                            
                            HStack {
                                Spacer()
                                Text(LocalKeys.CreateHobbyCardView.pleaseSelectRoadmapLanguage.rawValue.locale())
                                    .modifier(Px18Bold())
                                Spacer()
                            }
                            
                            Text(LocalKeys.CreateHobbyCardView.activeLanguages.rawValue.locale())
                                .modifier(Px16Regular())
                                .padding(.top, ProjectPaddings.huge.rawValue)
                            
                            HStack{
                                Button {
                                    vm.selectedLanguage = "tr"
                                }label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                                            .frame(width: geometry.dw(width: 0.3),height: geometry.dh(height: 0.1))
                                            .foregroundStyle(vm.selectedLanguage == "tr" ? Color.safetyOrange: .libertyBlue)
                                        
                                        Text(LocalKeys.General.tr.rawValue.locale())
                                            .foregroundStyle(.winterHaven)
                                            .modifier(Px16Bold())
                                    }
                                }
                                
                                Button {
                                    vm.selectedLanguage = "eng"
                                }label: {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                                            .frame(width: geometry.dw(width: 0.3),height: geometry.dh(height: 0.1))
                                            .foregroundStyle(vm.selectedLanguage == "eng" ? Color.safetyOrange: .libertyBlue)
                                        
                                        Text(LocalKeys.General.eng.rawValue.locale())
                                            .foregroundStyle(.winterHaven)
                                            .modifier(Px16Bold())
                                    }
                                }
                            }
                            
                            ButtonWithBg(action: {
                                vm.validateInputs(step: caseCounter)
                                if (!vm.showError) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        caseCounter += 1
                                    }
                                }
                            }, title: LocalKeys.General.next.rawValue.locale())
                        }
                        .padding()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                    
                case 3:
                    GeometryReader{geometry in
                        VStack(alignment:.center) {
                            HStack {
                                Spacer()
                                Text(LocalKeys.CreateHobbyCardView.selectLevel.rawValue.locale())
                                    .modifier(Px18Bold())
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            VStack(spacing:ProjectPaddings.normal.rawValue){
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.beginnerLevel.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.beginnerLevelDesc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.beginnerLevel.rawValue,
                                    isSelected: .constant(vm.selectedLevel == "beginner"),
                                    action: {
                                        vm.selectedLevel = "beginner"
                                    }
                                )
                                
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.intermediateLevel.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.intermediateLevelDesc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.mediumLevel.rawValue,
                                    isSelected: .constant(vm.selectedLevel == "intermediate"),
                                    action: {
                                        vm.selectedLevel = "intermediate"
                                    }
                                )
                                
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.advancedLevel.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.advancedLevelDesc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.highLevel.rawValue,
                                    isSelected: .constant(vm.selectedLevel == "advanced"),
                                    action: {
                                        vm.selectedLevel = "advanced"
                                    }
                                )
                            }.padding(.top,ProjectPaddings.large.rawValue)
                            
                            ButtonWithBg(action: {
                                vm.validateInputs(step: caseCounter)
                                if (!vm.showError) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        caseCounter += 1
                                    }
                                }
                            }, title: LocalKeys.General.next.rawValue.locale())
                            
                            Spacer()
                        }.padding()
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                case 4:
                    GeometryReader{geometry in
                        VStack{
                            HStack{
                                Spacer()
                                Text(LocalKeys.CreateHobbyCardView.chooseTheBudgetYouCanUseForThisHobby.rawValue.locale())
                                    .modifier(Px18Bold())
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            
                            VStack(spacing:ProjectPaddings.normal.rawValue){
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.minute15.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.minute15Desc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.minute15.rawValue,
                                    isSelected: .constant(vm.selectedMunite == 15)
                                ) {
                                    vm.selectedMunite = 15
                                }
                                
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.minute30.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.minute30Desc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.minute30.rawValue,
                                    isSelected: .constant(vm.selectedMunite == 30)
                                ) {
                                    vm.selectedMunite = 30
                                }
                                
                                CreateHobbyViewsCard(
                                    geometry: geometry,
                                    title: LocalKeys.CreateHobbyCardView.minute60.rawValue.locale(),
                                    description: LocalKeys.CreateHobbyCardView.minute60Desc.rawValue.locale(),
                                    imageName: ProjectImages.CreateHobbyViewImages.minute60.rawValue,
                                    isSelected: .constant(vm.selectedMunite == 60)
                                ) {
                                    vm.selectedMunite = 60
                                }
                            }.padding(.top,ProjectPaddings.huge.rawValue)
                            
                            ButtonWithBg(action: {
                                vm.validateInputs(step: caseCounter)
                                if (!vm.showError) {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        caseCounter += 1
                                    }
                                }
                            }, title: LocalKeys.General.next.rawValue.locale())
                            
                            Spacer()
                        }.padding()
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                case 5:
                    GeometryReader { geometry in
                        VStack {
                            HStack {
                                Spacer()
                                Text(LocalKeys.CreateHobbyCardView.explainWhyTexty.rawValue.locale())
                                    .modifier(Px18Bold())
                                    .multilineTextAlignment(.center)
                                Spacer()
                            }
                            
                            TextEditor(text: $vm.explainWhyText)
                                .frame(height: geometry.dh(height: 0.3))
                                .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                                .padding(.top, ProjectPaddings.huge.rawValue)
                            
                            ButtonWithBg(action: {
                                vm.validateInputs(step: caseCounter)
                                if !vm.showError {
                                    Task {
                                        await vm.createHobbyPlan()
                                        if !vm.showError {
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                NotificationCenter.default.post(name: Notification.Name("NavigateToHome"), object: nil)
                                            }
                                        }
                                    }
                                }
                            }, title: LocalKeys.General.finish.rawValue.locale())
                            
                            Spacer()
                        }
                        .padding()
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                default:
                    VStack {
                        Text("Hobby Creation Completed!")
                            .modifier(Px18Bold())
                            .padding(.top, ProjectPaddings.huge.rawValue)
                        
                        ButtonWithBg(action: {
                            // Implement your success action here
                        }, title: "Go to Dashboard")
                    }
                    .padding()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }.alert(isPresented: $vm.showError) {
                Alert(title: Text(LocalKeys.CreateHobbyViewErrorCode.createHobbyError.rawValue.locale()), message: Text(vm.errorMessage ?? ""), dismissButton: .default(Text(LocalKeys.General.okay.rawValue.locale())))
            }
            if vm.progress {
                ZStack {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.5)
                        
                        Text("")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .padding(30)
                    .background(
                        RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                            .fill(Color.libertyBlue.opacity(0.8))
                    )
                }
                .transition(.opacity)
            }
        }
        
        // Add loading overlay
        
        
        
    }
       
}


struct CreateHobbyView_Previews: PreviewProvider {
    static var previews: some View {
        CreateHobbyView()
    }
}

struct CreateHobbyViewsCard: View {
    var geometry: GeometryProxy
    var title: LocalizedStringKey
    var description: LocalizedStringKey
    var imageName: String
    @Binding var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
            isSelected.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue)
                    .stroke(lineWidth: 2)
                    .frame(height: geometry.dh(height: 0.15))
                    .foregroundStyle(isSelected ? Color.safetyOrange : Color.libertyBlue)
                HStack {
                    Image(imageName)
                        .resizable()
                        .frame(width: geometry.dw(width: 0.2), height: geometry.dh(height: 0.1))
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .modifier(Px16Bold())
                        
                        Text(description)
                            .modifier(Px16Regular())
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.leading, ProjectPaddings.medium.rawValue)
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    CreateHobbyView()
}
