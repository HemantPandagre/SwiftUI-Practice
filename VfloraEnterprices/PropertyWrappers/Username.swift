//
//  UsernameWrapper.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/04/26.
//
import Foundation

@propertyWrapper
struct Username {
    private var value: String = ""
    private var emptyError = "Please enter username"
    private var validUsername = "Please enter valid username"

    init() { self.value = "" }
    
    var wrappedValue: String {
        get { value }
        set { value = newValue.lowercased().trimmingCharacters(in: .whitespaces) }
    }

    // The "Projected Value" ($input) returns the first error message found
    var projectedValue: ValidationResult {
        if value.isEmpty {
           return ValidationResult(isValid: false, errorMessage: emptyError)
        } else if value.count < 3 {
            return ValidationResult(isValid: false, errorMessage: validUsername)
        } else {
            return ValidationResult(isValid: true)
        }
    }
}
