//
//  HabitCellView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI

struct HabitCellView: View {
    @ObservedObject var habit: Habit
    
    private var progress: Double {
        Double(habit.days) / 21
    }
    
    private var percentText: String {
        progress.formatted(.percent.precision(.fractionLength(2)))
    }
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
                
                ProgressView(value: progress)
                Text("\(percentText) completed")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}


#Preview {
    HabitCellView(habit: Habit(title: "Title", isDone: true, startDate: Date.now))
}
