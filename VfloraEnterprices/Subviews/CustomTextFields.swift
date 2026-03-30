//
//  CustomTextFields.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/03/26.
//

import SwiftUI

struct CustomTextField<Value: Hashable>: View {
    let icon: String?
    let placeholder: String
    let focusState: FocusState<Value?>.Binding
    let fieldIdentifier: Value
    @Binding var fieldText: String
    @State private var isSecure: Bool = false

    
    // MARK: - Init #1 (primary): covers both normal and password fields
     private init(icon: String?, placeholder: String, focusState: FocusState<Value?>.Binding, fieldIdentifier: Value, fieldText: Binding<String>, isSecure: Bool = false) {
          self.icon = icon
          self.placeholder = placeholder
          self.focusState = focusState
          self.fieldIdentifier = fieldIdentifier
          self._fieldText = fieldText
          self._isSecure = State(initialValue: isSecure ? true : false)
      }

    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                // Leading Icon
                if let icon = icon, !icon.isEmpty {
                  Image(systemName: icon)
                        .foregroundColor(Color.secondary)
                        .frame(width: 20, height: 30)
                }

                // Input Field
                if isSecure {
                    SecureField(placeholder, text: $fieldText)
                        .focused(focusState, equals: fieldIdentifier)
                    Button(action: { isSecure.toggle() }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.vfGray)
                    }
                } else {
                    TextField(placeholder, text: $fieldText)
                        .focused(focusState, equals: fieldIdentifier)
                }
            }
            .padding(.vertical, 4)

            // 1pt Bottom Border
            Rectangle()
                .fill(Color.vfGray.opacity(0.3))
                .frame(height: 1)
        }
    }
}

extension CustomTextField {
    
    static func normalField(icon: String? = nil, placeholder: String, focusState: FocusState<Value?>.Binding, fieldIdentifier: Value, fieldText: Binding<String>) -> CustomTextField {
        .init(icon: icon, placeholder: placeholder, focusState: focusState, fieldIdentifier: fieldIdentifier, fieldText: fieldText)
    }
    
    static func secureField(icon: String? = nil, placeholder: String, focusState: FocusState<Value?>.Binding, fieldIdentifier: Value, fieldText: Binding<String>) -> CustomTextField {
        .init(icon: icon, placeholder: placeholder, focusState: focusState, fieldIdentifier: fieldIdentifier, fieldText: fieldText, isSecure: true)
    }
}


