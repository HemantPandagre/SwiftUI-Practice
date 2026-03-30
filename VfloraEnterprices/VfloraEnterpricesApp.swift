//
//  VfloraEnterpricesApp.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 01/03/26.
//

import SwiftUI

@main
struct VfloraEnterpricesApp: App {
    @AppStorageCodable("currentUser") var user: User?
    @StateObject private var loader = LoaderService()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if user?.loginStatus == .loggedIn {
                    DashboardView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(loader)
        }
    }
}
