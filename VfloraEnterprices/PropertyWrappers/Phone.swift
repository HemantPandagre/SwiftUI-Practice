//
//  PasswordWrapper.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/04/26.
//
import Foundation

@propertyWrapper
struct Phone: Codable, Equatable {
    private var value: String
    
    // Requirements: 8+ chars, 1 Uppercase, 1 Lowercase, 1 Number
    private let regex = "^\\d{10}$"
    private let errorMessage = "Please enter valid Phone Number"

    init() { self.value = "" }
    
    init (_ wrappedValue: String) {
        value = wrappedValue
    }
    
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
