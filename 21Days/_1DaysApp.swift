//
//  _1DaysApp.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI

@main
struct _1DaysApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
