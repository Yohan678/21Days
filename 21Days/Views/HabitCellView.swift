//
//  HabitCellView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI

struct HabitCellView: View {
    @ObservedObject var habit: Habit
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(habit.title)
            Text(habit.startDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    HabitCellView(habit: Habit(title: "Title", isDone: true, startDate: Date.now))
}
