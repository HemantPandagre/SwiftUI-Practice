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
    @State private var loginData: LoginData = .init(username: "", password: "")
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
                VStack() {
                    appLoginIcon
                    
                    VStack(spacing: 20) {
                        welcomeText
                        fieldsView
                        forgotPasswordButton
                        loginButton
                        NavigationLink(destination: ProfileView(isSignup: true), isActive: $isSignupNav, label: {
                            EmptyView()
                        })
                    }
                    .padding(.top, 30)
                }
                
                Spacer()
                CopyrightLabel()
                    .padding(10)
            }
            .padding(.top, 30)
            .padding(.horizontal, 30)
            
            if loader.isShowing {
                GlobalLoaderView(message: "Logging in...")
            }
        }
        .onAppear(perform: {
            if user == nil {
                user = User.empty()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                if loginData.isEmpty {
                    focusedField = .username
                }
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
            CustomTextField.normalField(icon: "envelope", placeholder: "Enter username", focusState: $focusedField, fieldIdentifier: .username, fieldText: $loginData.username)
            
            if !isForgotPassword {
                CustomTextField.secureField(icon: "lock", placeholder: "Enter Password", focusState: $focusedField, fieldIdentifier: .password, fieldText: $loginData.password)
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
        if let usernameError = loginData.$username {
            alertMessage = usernameError
            showAlert = true
            return
        }
        
        if let passwordError = loginData.$password {
            alertMessage = passwordError
            showAlert = true
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
