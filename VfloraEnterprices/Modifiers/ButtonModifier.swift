//
//  Modifiers.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 12/03/26.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .font(.title3.bold())
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.accentColor)
            .cornerRadius(25)
    }
}

struct SecondaryButtonModifier: ViewModifier {
    var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .font(.title3.bold())
            .foregroundColor(.black)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(25)
            .overlay {
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.accentColor, lineWidth: 2)
            }
    }
}

struct CancelButtonModifier: ViewModifier {
    var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .font(.title3.bold())
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.red)
            .cornerRadius(25)
    }
}
