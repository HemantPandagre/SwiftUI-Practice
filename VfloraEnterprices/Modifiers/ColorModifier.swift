//
//  Modifiers.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 12/03/26.
//

import SwiftUI

struct BackgroundColorModifier: ViewModifier {
    var opacity: Double = 1.0
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [.blue, .purple],
                    startPoint: .topLeading, endPoint: .bottomTrailing).opacity(opacity) )
    }
}
