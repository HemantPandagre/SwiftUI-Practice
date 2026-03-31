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
    var navigationBarConfig: NavigationBarConfig? { nil }
    
    var body: some View {
        NavigationSyncView(config: navigationBarConfig) {
            rootView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .modifier(BackgroundColorModifier(opacity: 0.1))
        }
        .navigationBarHidden(true)
    }
}

// A small helper view to bridge the gap between the protocol and Environment
struct NavigationSyncView<Content: View>: View {
    @EnvironmentObject var navManager: NavigationManager
    @Environment(\.dismiss) private var dismiss
    let config: NavigationBarConfig?
    let content: () -> Content
    @State private var localPushTrigger: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: CompanyDetailView(),isActive: $localPushTrigger) {
                EmptyView()}
            content()
                .onAppear {
                    navManager.isCompanyDetailActive = false
                    if let config = config {
                        navManager.currentConfig = config
                    }
                }
                .onChange(of: navManager.isCompanyDetailActive) { newValue in
                    if newValue && navManager.currentConfig?.title == config?.title  {
                        localPushTrigger = true
                        navManager.isCompanyDetailActive = false // Reset the "remote control"
                    }
                }
                .onChange(of: navManager.shouldPerformBack) { newValue in
                    if newValue && config?.defaultBack == true {
                        // Perform the actual Pop
                        dismiss()
                        
                        // Reset the trigger so it doesn't pop multiple screens
                        navManager.shouldPerformBack = false
                    }
                }
        }
    }
}
