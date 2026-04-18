//
//  BookingsSectionView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 17/04/26.
//
import SwiftUI

struct BookingsSectionView: View {
    
    private let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.fixed(50), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        VStack {
            Text("Bookings")
                .font(Font.headline.bold())
                .foregroundStyle(Color.accentColor)
                .padding(.top, 10)
            
            // 🔥 FIXED HEADER (does not scroll)
            HStack() {
                Text("ID").bold().frame(width: 50, alignment: .leading)
                Text("Name").bold().frame(maxWidth: .infinity, alignment: .leading)
                Text("Category").bold().frame(maxWidth: .infinity, alignment: .leading)
                Text("Qty").bold().frame(width: 60, alignment: .trailing)
                Text("Status").bold().frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color.gray.opacity(0.2))   // header background
            .zIndex(1) // keep it above scroll content
            
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    // Header row
                    
                    
                    // Data rows
                    ForEach(1..<51) { index in
                        Text("\(index)")
                        Text("Hemant")
                        Text("Clothes")
                        Text("\(index * 2)")
                        Text("Received")
                    }
                }
                .padding()
            }
        }
    }
}
