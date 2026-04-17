//
//  PasswordWrapper.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/04/26.
//
import Foundation

@propertyWrapper
struct Password {
    private var value: String
    
    // Requirements: 8+ chars, 1 Uppercase, 1 Lowercase, 1 Number
    private let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    private let errorMessage = "Please follow the password requirements 8+ chars, 1 Uppercase, 1 Lowercase, 1 Number"

    init() { self.value = "" }
    
    var wrappedValue: String {
        get { value }
        set { value = newValue }
    }

    // Access this via $password
    var projectedValue: ValidationResult {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if predicate.evaluate(with: value) {
           return ValidationResult(isValid: true)
        } else {
            return ValidationResult(isValid: false, errorMessage: errorMessage)
        }
    }
}
