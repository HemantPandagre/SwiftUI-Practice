//
//  CategoryView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 26/03/26.
//

import SwiftUI

struct CategoryDetailView: BaseView {
    var navigationBarConfig: NavigationBarConfig? { NavigationBarConfig(title: category.title)}
    @AppStorageCodable("currentUser") var user: User?
    var category: CategoriesEnum
    @State var clickedOn: Bool = false
    
    var rootView: some View {
        VStack(spacing: 30) {
            Text("Add To Card")
            NavigationLink(destination: CategoryDetailView(category: .Books), isActive: $clickedOn, label: {EmptyView()})
            Button {
                clickedOn.toggle()
            } label: {
                Text("Click me")
                    .font(Font.body.weight(.bold))
                    .foregroundStyle(Color.blue)
                    .padding()
                    .cornerRadius(20)
            }

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
