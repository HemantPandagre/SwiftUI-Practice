//
//  Untitled.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 12/03/26.
//

import SwiftUI

struct NavigationBarConfig {
    var title: String
    var defaultBack = true
    var defaultLogo = true
    var leftButtons: [AnyView] = []
    var rightButtons: [AnyView] = []
}


struct CustomNavigationView<Content: View>: View {
    let config: NavigationBarConfig
    let content: () -> Content
    @State private var isCompanyDetailActive: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // Main bar content: left & right actions
                HStack {
                    HStack(spacing: 12) {
                        if config.defaultBack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.backward")
                                    .foregroundStyle(Color.white)
                            }
                        }
                        ForEach(0..<config.leftButtons.count, id: \.self) { i in
                            config.leftButtons[i]
                        }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 12) {
                        if config.defaultLogo {
                            Button {
                                tappedCompanyLogo()
                            } label: {
                                Image("vfloraButtonImage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 30)
                            }
                            NavigationLink(destination: CompanyDetailView(), isActive: $isCompanyDetailActive, label: {
                                EmptyView()
                            })
                        }
                    
                        ForEach(0..<config.rightButtons.count, id: \.self) { i in
                            config.rightButtons[i]
                        }
                    }
                    .padding(.horizontal, -20)
                }
                .padding(.horizontal, 12)
                .frame(height: 52)
                
                // Centered title overlays the button area
                Text(config.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.horizontal, 60) // protect from overlapping buttons
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .modifier(BackgroundColorModifier())

            content()
        }
    }
    
    func tappedCompanyLogo() {
        isCompanyDetailActive.toggle()
    }
}
