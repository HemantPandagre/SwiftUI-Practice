//
//  CustomTextFields.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/03/26.
//

import SwiftUI

struct CustomFieldAttribute<Value: Hashable> {
    let isSecure: Bool?
    let icon: CustomImageView?
    let title: String?
    let placeholder: String
    let focusState: FocusState<Value?>.Binding
    let fieldIdentifier: Value
    let fieldText: Binding<String>

    init(
        isSecure: Bool? = nil,
        icon: CustomImageView? = nil,
        title: String? = nil,
        placeholder: String,
        focusState: FocusState<Value?>.Binding,
        fieldIdentifier: Value,
        fieldText: Binding<String>
    ) {
        self.isSecure = isSecure
        self.icon = icon
        self.title = title
        self.placeholder = placeholder
        self.focusState = focusState
        self.fieldIdentifier = fieldIdentifier
        self.fieldText = fieldText
    }
}

struct CustomTextField<Value: Hashable>: View {

    private let fieldAttribute: CustomFieldAttribute<Value>

    @Binding private var fieldText: String
    @State private var hideText: Bool = false
    
    init(_ fieldAttribute: CustomFieldAttribute<Value>) {
        self.fieldAttribute = fieldAttribute
        self._fieldText = fieldAttribute.fieldText
        self._hideText = State(initialValue: fieldAttribute.isSecure ?? false)
    }

    var body: some View {
        HStack(spacing: 10) {
            if let icon = fieldAttribute.icon {
                icon
                    .padding(.leading, 30)
            }
            
            VStack(alignment: .leading) {
                fieldTitle
                if let isSecure = fieldAttribute.isSecure, isSecure {
                    HStack {
                        fieldView
                        eyeButton
                    }
                } else {
                    fieldView
                }
            }
            .padding(.leading, fieldAttribute.icon == nil ? 30 : 0)
        }
        .padding(.vertical, 20)
        .focused(
            fieldAttribute.focusState,
            equals: fieldAttribute.fieldIdentifier
        )
        .clipped()
    }
    
    var fieldTitle: some View {
        Group {
            if let title = fieldAttribute.title,
               !title.isEmpty {
                Text(title)
                    .font(.system(size: 17, weight: .bold))
            } else {
                EmptyView()
            }
        }
    }
    
    var fieldView: some View {
        return Group {
            if hideText {
                SecureField(fieldAttribute.placeholder, text: $fieldText)
            } else {
                TextField(fieldAttribute.placeholder, text: $fieldText)
            }
        }
        .font(.system(size: 15, weight: .bold))
        .foregroundStyle(.gray)
    }
    
    var eyeButton: some View {
        Button(action: { self.hideText.toggle() }) {
            Image(systemName: !self.hideText ? "eye.slash" : "eye")
                .foregroundColor(.vfGray)
        }
    }
}

private struct PreviewContainer: View {

    @State private var username = ""

    @FocusState private var focusedField: LoginField?

    var body: some View {

        let field: CustomFieldAttribute<LoginField> = .init(
            isSecure: true,
            icon: CustomImageView {
                Image(systemName: "person.fill")
            },
            placeholder: "Enter username",
            focusState: $focusedField,
            fieldIdentifier: .username,
            fieldText: $username
        )

        VStack(spacing: 20) {
            CustomTextField(field)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    PreviewContainer()
}
