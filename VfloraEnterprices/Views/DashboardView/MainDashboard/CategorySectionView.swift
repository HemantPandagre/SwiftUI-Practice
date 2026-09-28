//
//  CategorySectionView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 17/04/26.
//
import SwiftUI

struct CategorySectionView: View {
    let availableWidth: CGFloat
    let categories: [CategoriesEnum] = CategoriesEnum.allCases

    private let cardSize: CGFloat = 80
    private let gridSpacing: CGFloat = 10

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text("Categories")
                .font(Font.headline.bold())
                .foregroundStyle(Color.accentColor)

            LazyVGrid(columns: columns, spacing: gridSpacing) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink(destination: CategoryDetailView(category: category)) {
                        CategoryCard(name: category.title, icon: category.imageName)
                    }
                }
            }
            .frame(height: gridHeight)
        }
        .frame(maxWidth: .infinity, alignment: .top)
    }

    private var columnCount: Int {
        guard availableWidth >= cardSize else { return 1 }
        let count = Int((availableWidth + gridSpacing) / (cardSize + gridSpacing))
        return max(count, 1)
    }

    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.fixed(cardSize), spacing: gridSpacing),
            count: columnCount
        )
    }

    private var gridHeight: CGFloat {
        let rows = ceil(CGFloat(categories.count) / CGFloat(columnCount))
        return rows * cardSize + max(rows - 1, 0) * gridSpacing
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
