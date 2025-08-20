//
//  HabitGridView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/19/25.
//

import SwiftUI
import SwiftData

struct HabitGridView: View {
    var habit: Habit
    
    var body: some View {
        
        let row = 3
        let col = 7
        
        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
            ForEach(0..<3) { row in
                GridRow {
                    ForEach(0..<7) { col in
                        let boxIndex = row * 7 + col
                        
                        let isBoxFilled = boxIndex < habit.days
                        
                        HabitBoxView(boxIndex: boxIndex, isFilled: isBoxFilled)
                    }
                }
            }
        }
    }
}

#Preview {
    HabitGridView(habit: Habit(title: "Dummy Title", isDone: false))
}
