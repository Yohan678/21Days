//
//  DetailedHabitView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import SwiftUI
import SwiftData

struct DetailedHabitView: View {
//    @ObservedObject var habit: Habit
//    @EnvironmentObject var store: HabitStore
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.scenePhase) private var scenePhase
    
    var habit: Habit

    let progressViewTotal: Double = 100.00
    
    var body: some View {
        NavigationView {
            VStack {
                
                let completeDate = habit.startDate.addingTimeInterval(3600 * 24 * 21)
                
                Text("\(habit.startDate, style: .date) ~ \(completeDate, style: .date)")
                    .foregroundColor(.secondary)
                    .bold()
                    .navigationTitle(habit.title)
                    .navigationBarTitleDisplayMode(.inline)
                
                Spacer()

                Text("Progress")
                    .padding()
                    .font(.title)
                    .bold()
                
                Text("\(habit.percentText)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                MyProgressView(habit: habit)
                    .padding()
                
                
                if #available(iOS 16.0, *) {
                    HabitGridView(habit: habit)
                } else {
                    Text("It is available devices with iOS 16 or more")
                }
                
                
                    
                
                Spacer()
                
                if !habit.isDone {
                    DoneButtonView( habit: habit)
                }
                
            }
        }
        .onAppear {
            //Load Timer?
        }
    }
}

#Preview {
    DetailedHabitView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: [Habit.self, TimerManager.self], inMemory: true)
}
