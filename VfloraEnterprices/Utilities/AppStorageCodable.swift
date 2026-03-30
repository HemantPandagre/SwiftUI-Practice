//
//  AppStorageCodable.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 27/03/26.
//

import SwiftUI

@propertyWrapper
struct AppStorageCodable<T: Codable>: DynamicProperty {
    // This internal @AppStorage is the "engine" that refreshes the View
    @AppStorage private var storageData: Data
    private let defaultValue: T?

    // The value the View interacts with
    var wrappedValue: T? {
        get {
            // Decode the data from UserDefaults into your Model
            (try? JSONDecoder().decode(T.self, from: storageData)) ?? defaultValue
        }
        nonmutating set {
            // Encode your Model into Data and save it to UserDefaults
            if let data = try? JSONEncoder().encode(newValue) {
                storageData = data // This triggers the View refresh!
            }
        }
    }

    // Projected value allows you to use Bindings (e.g., $user)
    var projectedValue: Binding<T?> {
        Binding(
            get: { self.wrappedValue ?? nil },
            set: { self.wrappedValue = $0 }
        )
    }

    init(_ key: String) {
        self.defaultValue = nil
        
        // Initialize the internal @AppStorage with the encoded default value
        let initialData = (try? JSONEncoder().encode(self.defaultValue)) ?? Data()
        self._storageData = AppStorage(wrappedValue: initialData, key)
    }
}

