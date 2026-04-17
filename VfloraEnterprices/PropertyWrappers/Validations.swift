//
//  Validations.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 31/03/26.
//
import Foundation

@propertyWrapper
struct ValidatedInput {
    private var value: String = ""
    typealias Regex = (regex: String, errorMessage: String)
    private let regexBox: Regex?
    let rules: [(String) -> String?] // Returns an error message if invalid

    var wrappedValue: String {
        get { value }
        set { value = newValue }
    }

    // The "Projected Value" ($input) returns the first error message found
    var projectedValue: ValidationResult {
        if !rules.isEmpty {
            for rule in rules {
                if let error = rule(value) {
                    return ValidationResult(isValid: false, errorMessage: error) }
            }
        } else {
            if let regexBox = regexBox, value.range(of: regexBox.regex, options: .regularExpression) == nil {
                return ValidationResult(isValid: false, errorMessage: regexBox.errorMessage)
            }
        }
        return ValidationResult(isValid: true)
    }
    
    init(wrappedValue: String = "", regexBox: Regex) {
        self.value = wrappedValue
        self.rules = []
        self.regexBox = regexBox
    }

    init(wrappedValue: String = "", rules: [(String) -> String?]) {
        self.value = wrappedValue
        self.rules = rules
        self.regexBox = nil
    }
}
