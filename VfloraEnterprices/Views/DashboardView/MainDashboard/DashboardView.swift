//
//  DashboardView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 02/03/26.
//

import SwiftUI

struct DashboardView: BaseView {
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: "Dashboard", defaultBack: false, leftButtons: navLeftButtons) }
    
    var navLeftButtons: [AnyView] {
        [
            AnyView(
                Button {
                    isSidebarOpen.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundStyle(.white)
                }
            )
        ]
    }
    
    @EnvironmentObject var loader: LoaderService
    @AppStorageCodable("currentUser") var user: User?
    
    @State private var isSidebarOpen: Bool = false
    @State private var selectedItem: Menu?
    @State private var isLoggingout: Bool = false
    @State private var showAlert: Bool = false
    
    var rootView: some View {
            ZStack {
                VStack {
                    CategorySectionView()
                        .padding(.top, 10)
                    
                    BookingsSectionView()
                }
                
                SideMenuView(isSidebarOpen: $isSidebarOpen, showLogoutAlert: $showAlert, selectedItem: $selectedItem)
                
                if let menu = selectedItem {
                    NavigationLink(
                        destination: menu.destination,
                        isActive: Binding(get: { menu != .logout }, set: { _ in })
                    ) {
                        EmptyView()
                    }
                    .onAppear {
                        if menu == .logout { showAlert = true }
                    }
                }
                
                if loader.isShowing {
                    let message = isLoggingout ? "Logging out..." : "Loading Data..."
                    GlobalLoaderView(message: message)
                }
            }
            .onAppear {
                selectedItem = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    loader.hide()
                }
            }
            .alert("Logout", isPresented: $showAlert) {
                logoutButton()
                cancelButton()
            } message: {
                Text("Do You want to Logout?")
            }
    }
    
    func logoutButton() -> some View {
        Button {
            isLoggingout = true
            loader.isShowing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                isLoggingout = false
                loader.isShowing = false
                user?.loginStatus = .notLoggedIn
            })
        } label: {
            Text("Logout")
                .font(Font.subheadline.bold())
                .foregroundStyle(.red)
                .frame(width: 100, height: 40)
                .background(Color.red)
                .cornerRadius(20)
        }
    }
    
    func cancelButton() -> some View {
        Button {
            showAlert.toggle()
        } label: {
            Text("Cancel")
                .font(Font.subheadline.bold())
                .foregroundStyle(.white)
                .frame(width: 100, height: 40)
                .background(Color.red)
                .cornerRadius(20)
        }
    }
}


#Preview {
    DashboardView()
}
