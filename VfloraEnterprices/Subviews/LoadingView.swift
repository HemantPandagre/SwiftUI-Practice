//
//  LoadingView.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 13/03/26.
//
import SwiftUI
import Combine

 class LoaderService: ObservableObject {
    @Published var isShowing: Bool = false
    
    func show() { isShowing = true }
    func hide() { isShowing = false }

    // optional async helper
    func withLoading<T>(_ operation: () async throws -> T) async rethrows -> T {
        show()
        defer { hide() }
        return try await operation()
    }
}


struct GlobalLoaderView: View {
    let message: String
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ProgressView(message)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 10)
        }
    }
}

