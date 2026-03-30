//
//  CopyrightLabel.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 02/03/26.
//

import SwiftUI

struct CopyrightLabel: View {
    var color: Color = .black.opacity(0.7)
    
    var body: some View {
        Text("© 2026 VfloraEnterprices. All rights reserved.")
            .font(.caption2)
            .foregroundColor(color)
            .padding(.bottom, 12)
    }
}


