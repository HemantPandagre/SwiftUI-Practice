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
                VStack {
                    appLoginIcon
                        .padding(.top, 50)
                    
                    companyDetails()
                }
            }
        }
    }
    
    func companyDetails(_ alignment: Alignment = .top) -> some View {
        return VStack {
            VStack(alignment: .leading) {
                Text("Vflora: \nElegance in Bloom")
                    .font(Font.title.bold())
                    .padding(.top, 20)
                
                Text("Vflora is a premier floral design studio dedicated to the art of botanical storytelling. We specialize in creating sophisticated, custom arrangements that blend timeless elegance with modern flair. Whether for a grand event or a thoughtful personal gesture, Vflora transforms nature's finest elements into unforgettable visual experiences.")
                    .padding(.top, 10)
                    .font(Font.caption)
                    .foregroundStyle(.gray)
                    .lineSpacing(10)
            }
            .padding()
            .padding(.horizontal, 30)
            .frame(maxHeight: .infinity ,alignment: alignment)
            
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
