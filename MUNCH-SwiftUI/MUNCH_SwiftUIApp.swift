//
//  MUNCH_SwiftUIApp.swift
//  MUNCH-SwiftUI
//
//  Created by SCG on 10/22/21.
//

import SwiftUI

@main
struct MUNCH_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
