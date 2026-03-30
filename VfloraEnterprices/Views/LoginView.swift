//
//  ContentView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/03/26.
//

import SwiftUI
import Combine



struct LoginView: BaseView {
    enum LoginField {
        case username, password
    }
    
    var navigationBarConfig: NavigationBarConfig? { nil }
    
    @EnvironmentObject var loader: LoaderService
    @AppStorageCodable("currentUser") var user: User?
    
    @State private var username: String = "Hemant"
    @State private var password: String = "1234"
    @State private var isForgotPassword: Bool = false
    @State private var isDashboardNav: Bool = false
    @State private var isSignupNav: Bool = false
    @State private var alertTitle: String = "Error"
    @State private var alertMessage: String = ""
    @State private var showAlert: Bool = false
    @FocusState private var focusedField: LoginField?
    
    private var welcomeLabelText: String {
        isForgotPassword ? "Reset Password" : "Welcome to Vflora"
    }
    
    private var loginButtonText: String {
        isForgotPassword ? "Send Reset Link" : "Login"
    }
    
    var screenTitle: String? { nil }
    
    var rootView: some View {
        ZStack {
            VStack {
                VStack(alignment: .center, spacing: 30) {
                    appLoginIcon
                        .padding(.top, 50)
                    Spacer()
                    
                    VStack(spacing: 20) {
                        welcomeText
                        fieldsView
                        forgotPasswordButton
                        loginButton
                        NavigationLink(destination: ProfileView(isSignup: true), isActive: $isSignupNav, label: {
                            EmptyView()
                        })
                    }
                }
                .padding(30)
                .padding(.bottom, 100)
                
                Spacer()
                CopyrightLabel()
                    .padding(10)
            }
            
            if loader.isShowing {
                GlobalLoaderView(message: "Logging in...")
            }
        }
        .onAppear(perform: {
            if user == nil {
                user = User.empty()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                focusedField = .username
            }
        })
        .alert(alertTitle, isPresented: $showAlert) {
            Button("Ok") {
                
            }
        } message: {
            Text(alertMessage)
        }
       
    }
    
    var appLoginIcon: some View {
        Image("vfloraImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    var welcomeText: some View {
        Text(welcomeLabelText)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(Color.accent)
            .padding(.bottom, 0)
            .overlay(
                Rectangle()
                    .fill(Color.accent)
                    .frame(height: 1.5),
                alignment: .bottom)
    }
    
    var fieldsView: some View {
        Group {
            CustomTextField.normalField(icon: "envelope", placeholder: "Enter username", focusState: $focusedField, fieldIdentifier: .username, fieldText: $username)
            
            if !isForgotPassword {
                CustomTextField.secureField(icon: "lock", placeholder: "Enter Password", focusState: $focusedField, fieldIdentifier: .password, fieldText: $password)
            }
        }
    }
    
    var forgotPasswordButton: some View {
        HStack() {
            Spacer()
            if !isForgotPassword {
                Button(action: {
                    isForgotPassword.toggle()
                }, label: {
                    Text("Forgot Password?")
                        .font(.title2.bold())
                        .foregroundColor(Color.accentColor)
                        .frame(height: 50)
                        .frame(alignment: .trailing)
                        .cornerRadius(25)
                    
                })
            } else {
                EmptyView()
            }
        }
    }
    
    var loginButton: some View {
        
        VStack {
            Button {
                if (isForgotPassword) {
                    isForgotPassword.toggle()
                } else {
                    validationSignIn()
                }
            } label: {
                Text(loginButtonText)
                    .modifier(PrimaryButtonModifier())
            }
            
            if !isForgotPassword {
                Button {
                    user?.loginStatus = .signup
                    isSignupNav.toggle()
                } label: {
                    Text("Signup")
                        .modifier(SecondaryButtonModifier())
                }
            }
        }
    }
    
    func validationSignIn() {
        alertTitle = "Error"
        guard !username.isEmpty else {
            alertMessage = "Please enter username"
            showAlert.toggle()
            return
        }
        
        guard username.count >= 3 else {
            alertMessage = "Please enter valid username"
            showAlert.toggle()
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = "Please enter password"
            showAlert.toggle()
            return
        }
        focusedField = nil
        loader.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            user?.loginStatus = .loggedIn
        }
    }
}

#Preview {
    LoginView()
}
