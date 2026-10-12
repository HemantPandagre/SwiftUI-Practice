//
//  CompanyDetailView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 13/03/26.
//

import SwiftUI

struct CompanyDetailView: BaseView {
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: "Company Detail", defaultLogo: false)}
    
    var rootView: some View {
        
        GeometryReader { geo in
            let isExpanded = geo.size.width > 700
            if isExpanded {
                HStack(alignment: .center, spacing: 0) {
                    appLoginIcon
                        .frame(maxWidth: .infinity)

                    Divider()

                    companyDetails(.center)
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image("vfloraImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            //.padding(.top, 50)
                        
                        companyDetails()
                    }
                }
            }
        }
    }
    
    func companyDetails(_ alignment: Alignment = .top) -> some View {
        return VStack {
            VStack(alignment: .leading) {
                Text("SwiftUI: \nApple's Modern Language")
                    .font(Font.title.bold())
                    //.padding(.top, 20)
                
                Text("SwiftUI is Apple's modern, declarative software framework used to build native user interfaces across all Apple platforms—including iOS, iPadOS, macOS, watchOS, tvOS, and visionOS. SwiftUI is Apple's modern, declarative software framework used to build native user interfaces across all Apple platforms—including iOS, iPadOS, macOS, watchOS, tvOS, and visionOS.")
                    .padding(.top, 10)
                    .font(Font.body)
                    .foregroundStyle(.gray)
                    .lineSpacing(10)
            }
            .padding()
            .padding(.horizontal, 30)
            .frame(maxWidth: .infinity, alignment: alignment)
            
            Spacer()
            CopyrightLabel()
                .padding(10)
            
        }
    }
    
    var appLoginIcon: some View {
        Image("vfloraImage")
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
    }
}
