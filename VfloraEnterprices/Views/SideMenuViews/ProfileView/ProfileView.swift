//
//  ProfileView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 16/03/26.
//
import SwiftUI
import Combine

struct ProfileView: BaseView {
    
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: isSignup ? "Signup" : "Profile") }
    
    @AppStorageCodable("currentUser") var user: User?
    @EnvironmentObject var loader: LoaderService
    @State private var isEditable: Bool = false
    @State var isSignup: Bool = false
    

    var rootView: some View {
        ZStack {
            VStack {
                ScrollView {
                    VStack() {
                        if isEditable || isSignup {
                            ProfileDetailEditor(isEditable: $isEditable, isSignup: $isSignup)
                        } else {
                            ProfileDetailViewer(isEditable: $isEditable)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            
            if loader.isShowing {
                GlobalLoaderView(message: "Saving User Details...")
            }
        }
    }
}

#Preview {
    ProfileView()
}
