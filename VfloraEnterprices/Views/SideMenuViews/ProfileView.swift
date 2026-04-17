//
//  ProfileView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 16/03/26.
//
import SwiftUI
import Combine

enum ProfileField {
    case firstname, lastname, designation, email, phone, address
}

enum ProfileMessages {
    case noChange, successfull, signupPending, signupSuccess, emailInvalid, phoneInvalid
    
    var title: String {
        switch self {
        case .noChange: return "No changes made"
        case .successfull: return "Profile updated successfully"
        case .signupPending: return "Profile Pending"
        case .signupSuccess: return "Profile updated successfully"
        case .emailInvalid: return "Email is invalid"
        case .phoneInvalid: return "Phone is invalid"
        }
    }
    
    var message: String {
        switch self {
        case .noChange: return "Please make changes to update your profile."
        case .successfull: return "Your profile has been updated successfully."
        case .signupPending: return "Please fill all fields to create your profile."
        case .signupSuccess: return "Hurry! Profile created successfully 🚀"
        case .emailInvalid: return "Please enter valid email"
        case .phoneInvalid: return "Please enter valid phone number"
        }
    }
}

struct ProfileView: BaseView {
    
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: isSignup ? "Signup" : "Profile") }
    
    @AppStorageCodable("currentUser") var user: User?
    @EnvironmentObject var loader: LoaderService
    @State private var isEditable: Bool = false
    
    @FocusState private var focusedField: ProfileField?
    @State private var fieldData = User()
    
    @State private var alert: ProfileMessages = .noChange
    @State private var showAlert: Bool = false
    @State var isSignup: Bool = false
    

    var rootView: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack() {
                        if isEditable || isSignup {
                            editableUserFields
                        } else {
                            displayUserDetailsView
                        }
                    }
                }

                Spacer()
                
                if isEditable || isSignup {
                    saveCancelButtonsView
                } else {
                    editButtonView
                }
            }
            .padding(.horizontal, 20)
            
            if loader.isShowing {
                GlobalLoaderView(message: "Saving User Details...")
            }
        }
        .onAppear {
            if !isSignup {
                fieldData = user ?? User()
            }
        }
        .alert(alert.title, isPresented: $showAlert) {
            Button("Ok") {
                if alert == .successfull {
                    isEditable.toggle()
                }
            }
        } message: {
            Text(alert.message)
        }
    }
}

// Edit Form
extension ProfileView {
    var editableUserFields: some View {
        VStack(spacing: 20) {
            fieldView(heading: "First name", placeHolder: "Enter First name", fieldIdentifier: .firstname, focusState: $focusedField, fieldText: $fieldData.firstName)
            
            fieldView(heading: "Last name", placeHolder: "Enter Last name", fieldIdentifier: .lastname, focusState: $focusedField, fieldText: $fieldData.lastName)
            
            fieldView(heading: "Designation", placeHolder: "Enter designation", fieldIdentifier: .designation, focusState: $focusedField, fieldText: $fieldData.designation)
            
            fieldView(heading: "Email", placeHolder: "Enter email", fieldIdentifier: .email, focusState: $focusedField, fieldText: $fieldData.email)
            
            fieldView(heading: "Phone", placeHolder: "Enter phone", fieldIdentifier: .phone, focusState: $focusedField, fieldText: $fieldData.phone)
            
            fieldView(heading: "Address", placeHolder: "Enter address", fieldIdentifier: .address, focusState: $focusedField, fieldText: $fieldData.address)
            
            Spacer()
        }
        .padding(.top, 20)
    }
    
    func fieldView(heading: String, placeHolder: String, fieldIdentifier: ProfileField, focusState: FocusState<ProfileField?>.Binding, fieldText: Binding<String>) -> some View {
        VStack() {
            Text(heading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            CustomTextField.normalField(placeholder: placeHolder, focusState: focusState, fieldIdentifier: fieldIdentifier, fieldText: fieldText)
        }
    }
    
    var saveCancelButtonsView: some View {
        HStack {
            Button {
                validateAndSave()
            } label: {
                Text("Save")
                    .modifier(PrimaryButtonModifier())
            }
            
            Button {
                isEditable.toggle()
            } label: {
                Text("Cancel")
                    .modifier(CancelButtonModifier())
            }
        }
    }
}

// View Form
extension ProfileView {
    var displayUserDetailsView: some View {
        VStack(spacing: 20) {
            detailView(heading: "Full Name", subheading: user?.fullName ?? "")
            detailView(heading: "Designation", subheading: user?.designation ?? "")
            detailView(heading: "Email", subheading: user?.email ?? "")
            detailView(heading: "Phone", subheading: user?.phone ?? "")
            detailView(heading: "Address", subheading: user?.address ?? "")
            Spacer()
        }
        .padding(.top, 20)
    }
    
    func detailView(heading: String, subheading: String) -> some View {
        VStack() {
            Text(heading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text(subheading)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var editButtonView: some View {
        HStack {
            Button {
                isEditable.toggle()
            } label: {
                Text("Edit")
                    .modifier(PrimaryButtonModifier())
            }
        }
    }
}

// Data Save handling
extension ProfileView {
    func validateAndSave() {
        if fieldData.isEmpty() && isSignup { // if Signup data empty
            alert = .signupPending
            showAlert.toggle()
        }
        else if user == fieldData { // if No change in existing user data
            alert = .noChange
            showAlert.toggle()
        }
        else // if existing user data changed
        {
            if !fieldData.$email.isValid {
                alert = .emailInvalid
                showAlert.toggle()
                return
            }
            
            if !fieldData.$phone.isValid {
                alert = .phoneInvalid
                showAlert.toggle()
                return
            }

            
            user = fieldData
            loader.show()
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                loader.hide()
                if isSignup {
                    alert = .signupSuccess
                    showAlert.toggle()
                } else {
                    alert = .successfull
                    showAlert.toggle()
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
