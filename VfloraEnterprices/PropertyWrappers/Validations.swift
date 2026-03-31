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
    let rules: [(String) -> String?] // Returns an error message if invalid

    var wrappedValue: String {
        get { value }
        set { value = newValue }
    }

    // The "Projected Value" ($input) returns the first error message found
    var projectedValue: String? {
        for rule in rules {
            if let error = rule(value) { return error }
        }
        return nil
    }

    init(wrappedValue: String = "", rules: [(String) -> String?]) {
        self.value = wrappedValue
        self.rules = rules
    }
}
