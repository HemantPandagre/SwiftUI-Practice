//
//  SettingView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 30/03/26.
//

import SwiftUI

struct SettingView: BaseView {
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: "Settings")}
    @AppStorageCodable("currentUser") var user: User?
    
    var rootView: some View {
        VStack(spacing: 30) {
            Text("Settings View")
        }
    }

    func detailView(heading: String, subheading: String) -> some View {
        VStack {
            Text(heading)
                .font(.headline)
            Text(subheading)
                .font(.subheadline)
        }
    }
}

#Preview {
    ProfileView()
}
