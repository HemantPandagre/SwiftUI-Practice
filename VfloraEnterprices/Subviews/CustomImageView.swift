//
//  CustomImageView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/10/26.
//

import SwiftUI

struct CustomImageView: View {
    private let imageView: AnyView

    init<ImageView: View>(@ViewBuilder imageView: () -> ImageView) {
        self.imageView = AnyView(imageView())
    }

    var body: some View {
        imageView
    }
}
