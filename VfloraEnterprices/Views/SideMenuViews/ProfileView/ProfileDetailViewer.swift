//
//  ProfileDetailViewer.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 18/04/26.
//

import SwiftUI

struct ProfileDetailViewer: View {  
    @AppStorageCodable("currentUser") var user: User?
    @Binding var isEditable: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            detailView(heading: "Full Name", subheading: user?.fullName ?? "")
            detailView(heading: "Designation", subheading: user?.designation ?? "")
            detailView(heading: "Email", subheading: user?.email ?? "")
            detailView(heading: "Phone", subheading: user?.phone ?? "")
            detailView(heading: "Address", subheading: user?.address ?? "")
            Spacer()
        }
        .padding(.top, 20)
        
        editButtonView
    }
    
    func detailView(heading: String, subheading: String) -> some View {
        VStack() {
            Text(heading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            Text(subheading)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var editButtonView: some View {
        HStack {
            Button {
                isEditable.toggle()
            } label: {
                Text("Edit")
                    .modifier(PrimaryButtonModifier())
            }
        }
    }
}
