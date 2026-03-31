//
//  AppShell.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 31/03/26.
//
import SwiftUI

struct AppShell: View {
    // This manager holds the title/buttons for the bar
    @StateObject private var navManager = NavigationManager()
    @AppStorageCodable("currentUser") var user: User?
    @StateObject private var loader = LoaderService()

    var body: some View {
        VStack(spacing: 0) {
            if user?.loginStatus == .loggedIn {
                if let config = navManager.currentConfig {
                    CustomNavigationView(navManager: navManager, config: config)
                    
                }
                NavigationView {
                    ZStack {
                        DashboardView()
                        NavigationLink(destination: CompanyDetailView(), isActive: $navManager.isCompanyDetailActive, label: {EmptyView()})
                    }
                    
                }
                .environmentObject(navManager)
                
            } else {
                LoginView()
            }
            
        }
        .environmentObject(loader)
        .navigationViewStyle(.stack)
        .navigationBarHidden(true) // Hide the Apple default bar
    }
}
