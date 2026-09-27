//
//  CategorySectionView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 17/04/26.
//
import SwiftUI

struct CategorySectionView: View {
    let categories: [CategoriesEnum] = CategoriesEnum.allCases
    
    private let cardSize: CGFloat = 80
    private let gridSpacing: CGFloat = 10

    private var rows: [GridItem] {
        [
            GridItem(.fixed(cardSize), spacing: gridSpacing),
            GridItem(.fixed(cardSize), spacing: gridSpacing)
        ]
    }

    /// Two fixed rows plus the spacing between them.
    private var gridHeight: CGFloat { cardSize * 2 + gridSpacing }
    private var gridWidth: CGFloat { cardSize * 5 + (gridSpacing * 4) }

    
    var body: some View {
        VStack {
            Text("Categories")
                .font(Font.headline.bold())
                .foregroundStyle(Color.accentColor)
                .padding(.bottom, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, spacing: 10, pinnedViews: []) {
                    ForEach(categories, id: \.self) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCard(name: category.title, icon: category.imageName)
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(height: gridHeight)
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
