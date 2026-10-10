//
//  NewProfileView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 30/09/26.
//

import SwiftUI
import Combine

struct NewProfileView: BaseView {
    
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: isSignup ? "Signup" : "Profile") }
    
    @AppStorageCodable("currentUser") var user: User?
    @EnvironmentObject var loader: LoaderService
    @State private var isEditable: Bool = false
    @State var isSignup: Bool = false
    
    @State private var fieldData = User()
    @State private var username = ""
    @State private var secure = false

    @FocusState private var focusedField: ProfileField?
    
    var rootView: some View {
        ZStack {
            GeometryReader { geo in
                let isExpanded = geo.size.width > 700
                if isExpanded {
                    HStack {
                        VStack(spacing: 20) {
                            profilePic
                            name
                            designation
                            
                            VStack(spacing: 10) {
                                firstNameView
                                lastNameView
                                
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Divider()
                        
                        VStack(spacing: 10) {
                            emailView
                            phoneView
                            bioView
                        }
                        .padding(.horizontal, 20)
                    }
                } else {
                    VStack() {
                        ScrollView() {
                            VStack(spacing: 20) {
                                profilePic
                                name
                                designation
                                
                                VStack {
                                    firstNameView
                                    lastNameView
                                    emailView
                                    phoneView
                                    bioView
                                }
                                .padding(.horizontal, 20)
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

extension NewProfileView {
    var name: some View {
        Text("Hemant Pandagre")
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 30).bold())
            .padding(.bottom, -20)
    }
    
    var designation: some View {
        Text("Senior iOS Developer")
            .frame(maxWidth: .infinity, alignment: .center)
            .font(.system(size: 20))
            .padding(.bottom, 10)
    }
    
    var profilePic: some View {
        Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFill()
            .background(Color(.gray).opacity(0.4))
            .frame(width: 150, height: 150)
            .clipShape(Circle())
            .shadow(radius: 5)
            .padding(.top, 20)
    }
    var bioView: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text("User Bio")
                    .font(.system(size: 17, weight: .bold))
                
                TextField("Tell us something about you...",
                          text: $fieldData.designation)
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            .frame(height: 150)
            .cardStyle()
        }
    }
    
    var firstNameView: some View {
        fieldView(icon: customImage(name: "person.fill"),
                  heading: "First Name",
                  placeHolder: "Enter First name",
                  fieldIdentifier: .firstname,
                  focusState: $focusedField,
                  fieldText: $fieldData.firstName)
    }
    
    var lastNameView: some View {
        fieldView(icon: customImage(name: "person.fill"),
                  heading: "Last Name",
                  placeHolder: "Enter Last name",
                  fieldIdentifier: .lastname,
                  focusState: $focusedField,
                  fieldText: $fieldData.lastName)
    }
    
    var emailView: some View {
        fieldView(icon: customImage(name: "envelope"),
                  heading: "Email",
                  placeHolder: "Enter Email",
                  fieldIdentifier: .email,
                  focusState: $focusedField,
                  fieldText: $fieldData.email)
    }
    
    var phoneView: some View {
        fieldView(icon: customImage(name: "phone"),
                  heading: "Phone",
                  placeHolder: "Enter Phone number",
                  fieldIdentifier: .phone,
                  focusState: $focusedField,
                  fieldText: $fieldData.phone)
    }
}

//Fields Drawer
extension NewProfileView {
    func fieldView(icon: CustomImageView, heading: String, placeHolder: String, fieldIdentifier: ProfileField, focusState: FocusState<ProfileField?>.Binding, fieldText: Binding<String>) -> some View {
        let field: CustomFieldAttribute<ProfileField> = .init(
            isSecure: false,
            icon: icon,
            title: heading,
            placeholder: placeHolder,
            focusState: focusState,
            fieldIdentifier: fieldIdentifier,
            fieldText: fieldText
        )
        return CustomTextField(field)
            .cardStyle()
    }
    
    func customImage(name: String) -> CustomImageView {
        CustomImageView {
            Image(systemName: name)
                .resizable()
                .scaledToFit()
                .frame(width: 18, height: 18)
                .foregroundStyle(.gray)
                .frame(width: 40, height: 40)
                .background(.gray.opacity(0.2))
                .clipShape(.circle)
        }
    }
}


#Preview {
    NewProfileView()
        .environmentObject(NavigationManager())
}
