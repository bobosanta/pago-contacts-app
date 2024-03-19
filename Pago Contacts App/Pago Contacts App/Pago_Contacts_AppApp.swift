//
//  PagoContactsAppApp.swift
//  Pago Contacts App
//
//  Created by Santamarian Bogdan on 16.03.2024.
//

import SwiftData
import SwiftUI

@main
struct PagoContactsAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            UsersView()
        }
        .modelContainer(sharedModelContainer)
    }
}
