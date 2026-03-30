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
        VStack {
            appLoginIcon
                .padding(.top, 50)
            
            
            VStack(alignment: .leading) {
                Text("Vflora: Elegance in Bloom")
                    .font(Font.title.bold())
                    .padding(.top, 20)
                
                Text("Vflora is a premier floral design studio dedicated to the art of botanical storytelling. We specialize in creating sophisticated, custom arrangements that blend timeless elegance with modern flair. Whether for a grand event or a thoughtful personal gesture, Vflora transforms nature's finest elements into unforgettable visual experiences.")
                    .font(Font.caption.italic())
                    .foregroundStyle(.gray)
            }
            .padding()
            
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
