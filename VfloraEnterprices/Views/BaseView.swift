//
//  BaseView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/03/26.
//

import SwiftUI

protocol BaseView: View {
    associatedtype Content: View
    var navigationBarConfig: NavigationBarConfig? { get }
    @ViewBuilder var rootView: Content { get }
}

extension BaseView {

    var body: some View {
        VStack(spacing: 0) {
            if let navConfig = navigationBarConfig {
                CustomNavigationView(config: navConfig, content: {
                    self.getRootView()
                })
            } else {
                getRootView()
            }
        }
        .navigationBarHidden(true)
    }
    
    func getRootView() -> some View {
        rootView
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .modifier(BackgroundColorModifier(opacity: 0.1))
    }
}
