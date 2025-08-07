//
//  DetailedHabitView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI

struct DetailedHabitView: View {
    @ObservedObject var habit: Habit
    @EnvironmentObject var store: HabitStore
    
    var body: some View {
        NavigationView {
            Text("Started : \(habit.startDate, style: .date)")
                .navigationTitle(habit.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    DetailedHabitView(habit: Habit(title: "Dummy Title", isDone: false))
        .environmentObject(HabitStore())
}
