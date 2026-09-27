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
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Categories")
                .font(Font.headline.bold())
                .foregroundStyle(Color.accentColor)
                .padding(.bottom, 10)
            
            
            
            
            GeometryReader { proxy in
                let columns = getColoums(proxy: proxy)
                let rows = ceil(Double(categories.count) / Double(columns.count))
                 
                let gridHeight =
                rows * Double(cardSize) +
                (rows - 1) * Double(gridSpacing)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            NavigationLink(destination: CategoryDetailView(category: category)) {
                                CategoryCard(name: category.title, icon: category.imageName)
                            }
                        }
                    }
                }
                .frame(height: gridHeight)
            }
        }
    }
    
    private func getColoums(proxy: GeometryProxy) -> [GridItem] {
        let columnsCount = max(
            Int(proxy.size.width / (cardSize + gridSpacing)), 1
        )

        let columns = Array(
            repeating: GridItem(.fixed(cardSize), spacing: gridSpacing),
            count: columnsCount
        )
        return columns
    }
}


private struct CategoryCard: View {
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
