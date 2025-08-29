//
//  _1DaysApp.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI
import SwiftData

@main
struct _1DaysApp: App {
    @StateObject var habitStore = HabitStore()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView(habit: Habit(title: "Dummy Title", isDone: false))
        }
        .modelContainer(for: [Habit.self, TimerManager.self])
    }
}
