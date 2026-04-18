//
//  CategorySectionView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 17/04/26.
//
import SwiftUI

struct CategorySectionView: View {
    let categories: [CategoriesEnum] = CategoriesEnum.allCases
    
    let rows = [
        GridItem(.fixed(80), spacing: 10),
        GridItem(.fixed(80), spacing: 10)
    ]
    
    var body: some View {
        VStack {
            Text("Categories")
                .font(Font.headline.bold())
                .foregroundStyle(Color.accentColor)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 10, pinnedViews: []) {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCard(name: category.title, icon: category.imageName)
                        }
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
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
