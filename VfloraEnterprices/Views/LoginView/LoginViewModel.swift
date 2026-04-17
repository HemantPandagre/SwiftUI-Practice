//
//  LoginViewModel.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 15/04/26.
//
import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var loginData: LoginCredentials = .init(username: "Hemant", password: "Hemant123")
    @Published private(set) var isForgotPassword: Bool = false
    @Published private(set) var alertTitle: String = "Error"
    @Published private(set) var alertMessage: String = ""
    @Published var showAlert: Bool = false
    var successHandler: (() -> Void)?
    var failureHandler: (() -> Void)?
    
    var welcomeLabelText: String {
        isForgotPassword ? "Reset Password" : "Welcome to Vflora"
    }
    
    var loginButtonText: String {
        isForgotPassword ? "Send Reset Link" : "Login"
    }
    
    func forgotPasswordToggle() {
        isForgotPassword.toggle()
    }
    
    func validationSignIn() {
        alertTitle = "Error"
        let usernameResult = loginData.$username
        if !usernameResult.isValid {
            alertMessage = usernameResult.errorMessage
            showAlert = true
            self.failureHandler?()
            return
        }
        
        let passwordResult = loginData.$password
        if !passwordResult.isValid {
            alertMessage = passwordResult.errorMessage
            showAlert = true
            self.failureHandler?()
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.successHandler?()
        }
    }
}
