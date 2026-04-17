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

    @FocusState private var focusedField: LoginField?
    @State private var isDashboardNav: Bool = false
    @State private var isSignupNav: Bool = false
    
    @StateObject private var viewmodel: LoginViewModel = LoginViewModel()
    
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
                user = User()
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                if viewmodel.loginData.isEmpty {
                    focusedField = .username
                }
            }
        })
        .alert(viewmodel.alertTitle, isPresented: $viewmodel.showAlert) {
            Button("Ok") {
                
            }
        } message: {
            Text(viewmodel.alertMessage)
        }
        
    }
    
    var appLoginIcon: some View {
        Image("vfloraImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
    
    var welcomeText: some View {
        Text(viewmodel.welcomeLabelText)
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
            CustomTextField.normalField(icon: "envelope", placeholder: "Enter username", focusState: $focusedField, fieldIdentifier: .username, fieldText: $viewmodel.loginData.username)
            
            if !viewmodel.isForgotPassword {
                CustomTextField.secureField(icon: "lock", placeholder: "Enter Password", focusState: $focusedField, fieldIdentifier: .password, fieldText: $viewmodel.loginData.password)
            }
        }
    }
    
    var forgotPasswordButton: some View {
        HStack() {
            Spacer()
            if !viewmodel.isForgotPassword {
                Button(action: {
                    viewmodel.forgotPasswordToggle()
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
                focusedField = nil
                if (viewmodel.isForgotPassword) {
                    viewmodel.forgotPasswordToggle()
                } else {
                    loader.show()
                    viewmodel.successHandler = {
                        user?.setDummyData()
                        user?.loginStatus = .loggedIn
                    }
                    viewmodel.failureHandler = {
                        loader.hide()
                    }
                    viewmodel.validationSignIn()
                }
            } label: {
                Text(viewmodel.loginButtonText)
                    .modifier(PrimaryButtonModifier())
            }
            
            if !viewmodel.isForgotPassword {
                Button {
                    focusedField = nil
                    user?.loginStatus = .signup
                    isSignupNav.toggle()
                } label: {
                    Text("Signup")
                        .modifier(SecondaryButtonModifier())
                }
            }
        }
    }
    
    
}

#Preview {
    LoginView()
}
