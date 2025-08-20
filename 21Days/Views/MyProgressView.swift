//
//  MyProgressView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/20/25.
//

import SwiftUI
import SwiftData

struct MyProgressView: View {
    var habit: Habit
    
    let totalDays: Int = 21
    
    var fraction: Double {
        guard totalDays > 0 else { return 0 }
        let raw = Double(habit.days) / Double(totalDays)
        return min(max(raw, 0), 1)
    }
    
    var body: some View {
        ProgressView(value: fraction) {
        }
    }
}

#Preview {
    MyProgressView(habit: Habit(title: "Test", isDone: false))
}
