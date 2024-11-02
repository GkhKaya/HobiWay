//
//  InformationView.swift
//  HobiWay
//
//  Created by Gokhan Kaya on 19.10.2024.
//

import SwiftUI

struct InformationView: View {
    @State private var showInitialText = false
    @State private var showFullnamePart = false
    @State private var showContactText  = false
    @State private var showAgeAndGender = false
    @State private var showPhoneNumber = false
    @State private var showHobbyCategory = false
    @State private var showIntroduceYourSelf = false
    @State private var phoneNumber: String = ""
    @State private var selectedCountryCode = CountryCode(name: "Turkey", dial_code: "+90", code: "TR")
    
    @ObservedObject private var vm = InformationViewViewModel()
    
    @State private var selectedAge = 18
    @State private var selectedGender = 0
    let genders = [
        LocalKeys.General.man.rawValue.locale(),
        LocalKeys.General.woman.rawValue.locale(),
        LocalKeys.General.other.rawValue.locale()
    ]
    
    
    // Alert için gerekli değişken
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.winterHaven.ignoresSafeArea()
                
                // MARK: - Initial text
                if showInitialText {
                    Text(LocalKeys.InformationView.letsGetToNowYouALittleBit.rawValue.locale())
                        .modifier(Px24Bold()).multilineTextAlignment(.center)
                        .padding()
                }
                
                // MARK: - Fullname Part
                if showFullnamePart {
                    VStack {
                        Text(LocalKeys.InformationView.firstLetsLearnYourName.rawValue.locale())
                            .modifier(Px24Bold())
                            .multilineTextAlignment(.center)
                        
                        TextFieldWidget(title: LocalKeys.General.fullName.rawValue.locale(), iconName: "person.fill", text: $vm.name)
                        
                        ButtonWithBg(action: {
                            if vm.name.isEmpty {
                                alertMessage = LocalKeys.InformationViewError.pleaseEnterYourName.rawValue
                                showAlert = true
                            } else {
                                Task{
                                    withAnimation(.easeOut(duration: 1.0)){
                                        showFullnamePart = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                        withAnimation(.easeIn(duration: 1.0)){
                                            showContactText = true
                                        }
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                        withAnimation(.easeOut(duration: 1.0)) {
                                            showContactText = false
                                        }
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                        withAnimation(.easeOut(duration: 1.0)) {
                                            showAgeAndGender = true
                                        }
                                    }
                                }
                            }
                        }, title: LocalKeys.General.next.rawValue.locale())
                    }
                    .padding()
                }
                
                // MARK: - Contact Text
                if showContactText {
                    VStack(){
                        
                        
                        HStack{
                            Text(LocalKeys.General.hello.rawValue.locale())
                                .multilineTextAlignment(.center)
                                .modifier(Px24Bold())
                            Text("\(vm.name)")
                                .multilineTextAlignment(.center)
                                .modifier(Px24Bold())
                            
                            
                            
                        }
                        
                        Text(LocalKeys.InformationView.weAreHobiWayDevelopmentTeam.rawValue.locale())
                            .multilineTextAlignment(.center)
                            .modifier(Px16Bold())
                        
                        
                        Text(LocalKeys.InformationView.youCanReachUsAnytimeAtHobiwaycontactdevosuitcom.rawValue.locale())
                            .multilineTextAlignment(.center)
                            .modifier(Px16Bold())
                            .padding(.top,ProjectPaddings.large.rawValue)
                    }.padding()
                }
                
                // MARK: - Age and Gender Part
                if showAgeAndGender {
                    VStack {
                        
                        HStack {
                            Button {
                                withAnimation {
                                    showAgeAndGender = false
                                    showFullnamePart = true
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.libertyBlue)
                            }
                            Spacer()
                        }
                        
                        Spacer()
                        Text(LocalKeys.InformationView.nowLetsKnowYourAgeAndGender.rawValue.locale())
                            .modifier(Px24Bold())
                            .multilineTextAlignment(.center)
                        
                        
                        HStack {
                            VStack {
                                Text(LocalKeys.General.age.rawValue.locale())
                                    .modifier(Px16Bold())
                                
                                Picker("Yaş", selection: $selectedAge) {
                                    ForEach(6..<101) { age in
                                        Text("\(age)").tag(age)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)
                                .tint(.libertyBlue)
                            }
                            .padding(.trailing, ProjectPaddings.huge.rawValue)
                            
                            VStack {
                                Text(LocalKeys.General.gender.rawValue.locale())
                                    .modifier(Px16Bold())
                                
                                Picker("Cinsiyet", selection: $selectedGender) {
                                    Group {
                                        Text(LocalKeys.General.man.rawValue.locale()).tag(0)
                                        Text(LocalKeys.General.woman.rawValue.locale()).tag(1)
                                        Text(LocalKeys.General.other.rawValue.locale()).tag(2)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)
                                .tint(.libertyBlue)
                            }
                        }
                        .padding(.top, ProjectPaddings.normal.rawValue)
                        
                        ButtonWithBg(action: {
                            vm.selectedAge = selectedAge
                            vm.selectedGender = selectedGender
                            
                            withAnimation(.easeOut(duration: 1.0)) {
                                showAgeAndGender = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    showPhoneNumber = true
                                }
                            }
                        }, title: LocalKeys.General.next.rawValue.locale())
                        
                        Spacer()
                    }
                    .padding()
                }
                // MARK: - Phone Number Part
                if showPhoneNumber {
                    
                    
                    VStack {
                        
                        HStack {
                            Button() {
                                withAnimation {
                                    showPhoneNumber = false
                                    showAgeAndGender = true
                                }
                                
                            }label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.libertyBlue)
                            }
                            Spacer()
                        }
                        Spacer()
                        Text(LocalKeys.InformationView.nextIsYourpPhoneNumber.rawValue.locale())
                            .modifier(Px24Bold())
                            .multilineTextAlignment(.center)
                        
                        PhoneNumberTextField(
                            title: "Telefon Numarası",
                            text: $phoneNumber,
                            selectedCountryCode: $selectedCountryCode
                        )
                        
                        ButtonWithBg(action: {
                            if phoneNumber.isEmpty {
                                alertMessage = LocalKeys.InformationViewError.pleaseEnterYourPhoneNumber.rawValue
                                showAlert = true
                            } else {
                                Task{
                                    vm.fullPhoneNumber = "\(selectedCountryCode.dial_code)\(phoneNumber)"
                                    withAnimation(.easeOut(duration:1.0)) {
                                        showPhoneNumber = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.easeInOut(duration: 1.0)) {
                                            showHobbyCategory = true
                                        }
                                    }
                                    try await vm.fetchHobbyCategory()
                                    
                                }
                                
                            }
                        }, title: LocalKeys.General.next.rawValue.locale())
                        .padding(.top, ProjectPaddings.normal.rawValue)
                        
                        Spacer()
                    }
                    .padding()
                }
                
                // MARK: - Hobby Category
                if showHobbyCategory {
                    VStack {
                        if vm.showProgress{
                            ProgressView()
                        }else{
                            
                            HStack {
                                Button() {
                                    withAnimation {
                                        showHobbyCategory = false
                                        showPhoneNumber = true
                                    }
                                    
                                }label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.libertyBlue)
                                }
                                Spacer()
                            }
                            Spacer()
                            Text(LocalKeys.InformationView.pleaseSelectYouInterest.rawValue.locale())
                                .modifier(Px24Bold())
                                .multilineTextAlignment(.center)
                            
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: geometry.dw(width: 0.3)))]) {
                                    ForEach(vm.hobbyCategoery, id: \.id) { category in
                                        Button(action: {
                                            if vm.selectedInterests.contains(where: { $0.id == category.id }) {
                                                // If the category is already selected, remove it from the list
                                                vm.selectedInterests.removeAll { $0.id == category.id }
                                            } else {
                                                // Otherwise, add it to the selected categories list
                                                vm.selectedInterests.append(category)
                                            }
                                        }) {
                                            VStack {
                                                Text(category.name)
                                                    .foregroundStyle(Color.winterHaven)
                                                    .modifier(Px16Bold())
                                                    .frame(width:geometry.dw(width: 0.3),height:geometry.dh(height: 0.1))
                                                    .background(vm.selectedInterests.contains(where: { $0.id == category.id }) ? Color.safetyOrange : Color.libertyBlue)
                                                    .cornerRadius(ProjectRadius.normal.rawValue)
                                                
                                            }
                                            .padding()
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            
                            ButtonWithBg(action: {
                                if vm.selectedInterests.count < 2 {
                                    alertMessage = LocalKeys.InformationViewError.pleaseSelectLeastTwoInterest.rawValue
                                    showAlert = true
                                } else {
                                    withAnimation(.easeOut(duration:1.0)) {
                                        showHobbyCategory = false
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        withAnimation(.easeInOut(duration: 1.0)) {
                                            showIntroduceYourSelf = true
                                        }
                                    }
                                }
                            }, title: LocalKeys.General.next.rawValue.locale())
                            .padding(.top, ProjectPaddings.normal.rawValue)
                            
                            Spacer()
                        }
                       
                    }
                    .padding()
                }
                
                // MARK: - Introduce Yourself
                if showIntroduceYourSelf {
                    VStack {
                        
                        
                        HStack {
                            Button() {
                                withAnimation {
                                    showIntroduceYourSelf = false
                                    showHobbyCategory = true
                                }
                                
                            }label: {
                                Image(systemName: "chevron.left")
                                    .foregroundStyle(.libertyBlue)
                            }
                            Spacer()
                        }
                        Spacer()
                        
                        Text(LocalKeys.InformationView.finallyTellUsALittleAboutYourself.rawValue.locale())
                            .modifier(Px24Bold())
                            .multilineTextAlignment(.center)
                        
                        TextEditor(text: $vm.userAboutText)
                            .frame(height: geometry.dh(height: 0.3))
                            .clipShape(RoundedRectangle(cornerRadius: ProjectRadius.normal.rawValue))
                        
                        ButtonWithBg(action: {
                            if vm.userAboutText.isEmpty || vm.userAboutText.count < 100 {
                                alertMessage = LocalKeys.InformationViewError.pleaseEnterLeast100Characters.rawValue
                                showAlert = true
                            } else {
                                Task{
                                    do{
                                       try await vm.addUserInformation()
                                    }
                                }
                            }
                        }, title: LocalKeys.General.finish.rawValue.locale())
                        .padding(.top, ProjectPaddings.normal.rawValue)
                        .navigationDestination(isPresented: $vm.openHomeView) {
                            HomeView()
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(LocalKeys.General.alert.rawValue.locale()), message: Text(alertMessage), dismissButton: .default(Text(LocalKeys.General.okay.rawValue.locale())))
            }
            .onAppear {
                withAnimation(.easeIn(duration: 1.0)) {
                    showInitialText = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeInOut(duration: 1.0)) {
                        showInitialText = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeIn(duration: 1.0)) {
                            showFullnamePart = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    InformationView()
}





struct CountryCodePicker: View {
    @Binding var selectedCountryCode: CountryCode
    @State private var searchText: String = ""
    let countries: [CountryCode]
    @Environment(\.dismiss) var dismiss // Dismiss environment variable to close the sheet
    
    var filteredCountries: [CountryCode] {
        if searchText.isEmpty {
            return countries
        } else {
            return countries.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.dial_code.contains(searchText) ||
                $0.code.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredCountries) { country in
                    Button(action: {
                        selectedCountryCode = country
                        dismiss() // Automatically close the sheet after selection
                    }) {
                        HStack {
                            Text(country.dial_code)
                            Text(country.name)
                            Spacer()
                            Text(country.code)
                        }
                    }
                }
            }
            .navigationTitle("Ülke Kodu Seç")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}
