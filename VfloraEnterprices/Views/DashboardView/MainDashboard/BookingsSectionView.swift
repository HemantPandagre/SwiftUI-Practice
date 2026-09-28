//
//  BookingsSectionView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 17/04/26.
//
import SwiftUI

struct BookingsSectionView: View {
    
    private let columnSpacing: CGFloat = 8
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Text("Bookings")
                    .font(Font.headline.bold())
                    .foregroundStyle(Color.accentColor)
                    .padding(.bottom, 10)
                
                let rowWidth = max(geo.size.width - 24, 0)
                bookingRow(
                    id: "ID",
                    name: "Name",
                    category: "Category",
                    qty: "Qty",
                    status: "Status",
                    isHeader: true,
                    width: rowWidth
                )
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.2))
                
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(1..<51, id: \.self) { index in
                            ZStack {
                                if (index % 2) == 0 {
                                    Color.gray.opacity(0.3)
                                }
                                
                                bookingRow(
                                    id: "\(index)",
                                    name: "Hemant",
                                    category: "Clothes",
                                    qty: "\(index * 2)",
                                    status: "Received",
                                    isHeader: false,
                                    width: rowWidth
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                }
            }
        }
    }
    
    private func bookingRow(
        id: String,
        name: String,
        category: String,
        qty: String,
        status: String,
        isHeader: Bool,
        width: CGFloat
    ) -> some View {
        let columnCount: CGFloat = 5
        let contentWidth = width - columnSpacing * (columnCount - 1)
        return HStack(spacing: columnSpacing) {
            cell(id, isHeader: isHeader, alignment: .center)
                .frame(width: contentWidth * 0.10, alignment: .center)
            cell(name, isHeader: isHeader, alignment: .leading)
                .frame(width: contentWidth * 0.36, alignment: .leading)
            cell(category, isHeader: isHeader, alignment: .leading)
                .frame(width: contentWidth * 0.18, alignment: .leading)
            cell(qty, isHeader: isHeader, alignment: .center)
                .frame(width: contentWidth * 0.18, alignment: .center)
            cell(status, isHeader: isHeader, alignment: .leading)
                .frame(width: contentWidth * 0.18, alignment: .leading)
        }
        .frame(width: width, alignment: .leading)
    }

    private func cell(_ text: String, isHeader: Bool, alignment: Alignment) -> some View {
        Text(text)
            .font(isHeader ? Font.caption.bold() : Font.caption)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .frame(maxWidth: .infinity, alignment: alignment)
    }

}
