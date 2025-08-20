//
//  HabitCellView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI
import SwiftData

struct HabitCellView: View {
    @Environment(\.modelContext) private var modelContext

    var habit: Habit
    

    var body: some View {
        HStack {
            Image(systemName: habit.isDone ? "checkmark.circle.fill" : "checkmark.circle")
                .font(.title)
                .padding()
            
            VStack(alignment: .leading) {
                Text(habit.title)
                Text(habit.startDate, style: .date)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                MyProgressView(habit: habit)
                
                Text("\(habit.percentText) completed")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}


#Preview {
    HabitCellView(habit: Habit(title: "Title", isDone: true, startDate: Date.now))
        .modelContainer(for: Habit.self, inMemory: true)
}
