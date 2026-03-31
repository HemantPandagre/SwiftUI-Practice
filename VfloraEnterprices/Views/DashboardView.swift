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
    
    let rows = [
        GridItem(.fixed(80), spacing: 10),
        GridItem(.fixed(80), spacing: 10)
    ]
    
    
    private let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.fixed(50), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    
    let categories: [CategoriesEnum] = CategoriesEnum.allCases
    @EnvironmentObject var loader: LoaderService
    @AppStorageCodable("currentUser") var user: User?
    
    @State private var isSidebarOpen: Bool = false
    @State private var selectedItem: Menu?
    @State private var isLoggingout: Bool = false
    @State private var showAlert: Bool = false
    
    var rootView: some View {
            ZStack {
                VStack {
                    Text("Categories")
                        .font(Font.headline.bold())
                        .foregroundStyle(Color.accentColor)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 10, pinnedViews: []) {
                            ForEach(categories, id: \.self) { category in
                                NavigationLink(destination: CategoryView(category: category)) {
                                    CategoryCard(name: category.title, icon: category.imageName)
                                }
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    }
                    .padding(.top, 10)
                    
                    Text("Bookings")
                        .font(Font.headline.bold())
                        .foregroundStyle(Color.accentColor)
                        .padding(.top, 10)
                    
                    // 🔥 FIXED HEADER (does not scroll)
                    HStack() {
                        Text("ID").bold().frame(width: 50, alignment: .leading)
                        Text("Name").bold().frame(maxWidth: .infinity, alignment: .leading)
                        Text("Category").bold().frame(maxWidth: .infinity, alignment: .leading)
                        Text("Qty").bold().frame(width: 60, alignment: .trailing)
                        Text("Status").bold().frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))   // header background
                    .zIndex(1) // keep it above scroll content
                    
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 12) {
                            // Header row
                            
                            
                            // Data rows
                            ForEach(1..<51) { index in
                                Text("\(index)")
                                Text("Hemant")
                                Text("Clothes")
                                Text("\(index * 2)")
                                Text("Received")
                            }
                        }
                        .padding()
                    }
                    
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
                    let message = isLoggingout ? "Logging out..." : "Logging in..."
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
            } message: {
                Text("Do You want to Logout?")
            }
    }
}

struct CategoryCard: View {
    let name: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
            Text(name)
                .font(Font.caption.bold())
        }
        .frame(width: 80, height: 80, alignment: .center)
        .background(Color.gray.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}


#Preview {
    DashboardView()
}
