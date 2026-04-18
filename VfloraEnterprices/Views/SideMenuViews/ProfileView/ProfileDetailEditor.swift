//
//  D.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 18/04/26.
//
import SwiftUI

struct ProfileDetailEditor: View {
    @AppStorageCodable("currentUser") var user: User?
    @Binding var isEditable: Bool
    @Binding var isSignup: Bool
    
    @FocusState private var focusedField: ProfileField?
    @State private var fieldData = User()
    @State private var alert: ProfileMessages = .noChange
    @State private var showAlert: Bool = false
    @EnvironmentObject var loader: LoaderService
    
    
    var body: some View {
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
        
        saveCancelButtonsView
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

// Data Save handling
extension ProfileDetailEditor {
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
