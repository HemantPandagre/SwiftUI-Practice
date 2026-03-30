//
//  SideMenuView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 12/03/26.
//
import SwiftUI

enum Menu: String, CaseIterable {
    case profile, addToCard, settings, logout
    
    var displayName: String {
        switch self {
        case .profile: "Profile"
        case .addToCard: "Add to Card"
        case .settings: "Settings"
        case .logout: "Logout"
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .settings:  SettingView()
        case .addToCard: AddToCardView()
        case .profile:   ProfileView()
        case .logout:    EmptyView() // Handled by alert
        }
    }
}

struct SideMenuView: View {
   
    
    var screenTitle: String? { nil }
    var menuItems: [Menu] = Menu.allCases
    
    @Binding var isSidebarOpen: Bool
    @Binding var showLogoutAlert: Bool
    @Binding var selectedItem: Menu?
    @AppStorageCodable("currentUser") var user: User?
    
    var body: some View {
        GeometryReader { proxy in
            let totalWidth = proxy.size.width
            let widthRatio = 0.7
            
            ZStack(alignment: .leading) {
                if isSidebarOpen {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation { isSidebarOpen.toggle() }
                        }
                }
                
                VStack {
                    userDetailView(proxy: proxy)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.3))
                        .padding(.top, 20)
                    
                    menuListView(proxy: proxy)
                    
                     Spacer()
                    
                    CopyrightLabel(color: .black)
                        .padding(10)
                }
                .frame(width: totalWidth * widthRatio, alignment: .leading)
                .background(.white)
                .modifier(BackgroundColorModifier(opacity: 0.1))
                .offset(x: isSidebarOpen ? 0 : -(totalWidth * widthRatio))
                .animation(.easeInOut, value: isSidebarOpen)
            }
        }
        //.background(Color(.white))
    }
    
    func userDetailView(proxy: GeometryProxy) -> some View {
        return HStack {
            VStack(alignment: .leading) {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    .padding()
                
                Text(user?.fullName ?? "")
                    .font(.headline).bold()
                    .foregroundStyle(.white)
                
                Text(user?.designation ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                
                Text(user?.address ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.3))
                
            }
            .padding(.leading, 20)
            .padding(.bottom, 20)
            
            Spacer()
        }
        .modifier(BackgroundColorModifier()) // 🔥 width
    }

    func menuListView(proxy: GeometryProxy) -> some View {
        return HStack {
            VStack(alignment: .leading, spacing: 30) {
                ForEach(menuItems, id: \.self) { menu in
                    
                    VStack(alignment: .leading, spacing: 30) {
                        Button {
                            redirectTo(menu: menu)
                        } label: {
                            Text(menu.displayName)
                                .font(Font.headline.bold())
                                .foregroundStyle(menu.displayName.lowercased() == "logout" ? .red : .black)
                            
                        }
                        Rectangle()
                            .frame(height: 1)
                            .background(.gray).opacity(0.2)
                    }
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .font(.caption.bold())
            
            
            Spacer()
        }
    }
    
    func redirectTo(menu: Menu) {
        print("Redirecting to: \(menu.displayName)")
        isSidebarOpen.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            selectedItem = menu
        })
    }
}
