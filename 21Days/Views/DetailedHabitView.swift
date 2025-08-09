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
            VStack {
                Text("Started : \(habit.startDate, style: .date)")
                    .navigationTitle(habit.title)
                    .navigationBarTitleDisplayMode(.inline)
                
                
                Button {
                    habit.completeDay()
                } label: {
                    Text("Done")
                }
                
                if #available(iOS 16.0, *) {
                    Grid(horizontalSpacing: 10, verticalSpacing: 10) {
                        ForEach(0..<3) { row in
                            GridRow {
                                ForEach(0..<7) { col in
                                    let boxIndex = row * 7 + col
                                    
                                    let isBoxFilled = boxIndex < habit.days.count
                                    
                                    HabitBoxView(boxIndex: boxIndex, isFilled: isBoxFilled)
                                }
                            }
                        }
                    }
                } else {
                    Text("It is available devices with iOS 16 or more")
                }
            }
        }
    }
}

#Preview {
    DetailedHabitView(habit: Habit(title: "Dummy Title", isDone: false))
        .environmentObject(HabitStore())
}
