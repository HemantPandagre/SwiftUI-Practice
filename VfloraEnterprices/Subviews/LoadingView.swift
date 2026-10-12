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
    @Published var message: String = "Loading..."
    
    func show(_ message: String = "Loading...") {
        self.message = message
        isShowing = true
    }
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
            
            ProgressView(message)
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .ignoresSafeArea(.all)
    }
}

