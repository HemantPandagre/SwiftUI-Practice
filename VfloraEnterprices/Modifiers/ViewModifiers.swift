//
//  ViewModifiers.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 11/10/26.
//

import SwiftUI

struct BorderStyle {
    let color: Color
    let lineWidth: CGFloat
}

struct CardStyleModifier: ViewModifier {
    let cornerRadius: CGFloat
    let border: BorderStyle?

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white)
            )
            .overlay {
                if let border {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(border.color, lineWidth: border.lineWidth)
                }
            }
    }
}

extension View {
    func cardStyle(
        cornerRadius: CGFloat = 20,
        border: BorderStyle? = BorderStyle(color: .gray.opacity(0.3),lineWidth: 1)
    ) -> some View {
        modifier(
            CardStyleModifier(
                cornerRadius: cornerRadius,
                border: border
            )
        )
    }
}
