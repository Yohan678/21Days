//
//  HabitStore.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import Foundation

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []
    
    init() {
        habits = [
            Habit(title: "Running", isDone: false, startDate: Date.now),
            Habit(title: "Reading", isDone: true, startDate: Date.now.addingTimeInterval(3600 * -24 * 21), days: 21),
            Habit(title: "Working Out", isDone: true, startDate: Date.now.addingTimeInterval(3600 * -24 * 42), days: 21)
        ]
    }
    
    func insertNewHabit(title: String, startDate: Date) {
        habits.insert(Habit(title: title, isDone: false, startDate: startDate), at: 0)
    }
    
    func updateHabit(habit: Habit?, title: String, isDone: Bool) {
        guard let habit = habit else { return }
        habit.title = title
        habit.isDone = isDone
    }
}


