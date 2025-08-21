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
    @StateObject private var TM = TimerManager()
    
    var habit: Habit

    let progressViewTotal: Double = 100.00
    
    var body: some View {
        NavigationView {
            VStack {
                
                let completeDate = habit.startDate.addingTimeInterval(3600 * 24 * 21)
                
                Text("\(habit.startDate, style: .date) ~ \(completeDate, style: .date)")
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
                
                
                Text("Streaks")
                    .padding()
                    .font(.title)
                    .bold()
                
                VStack {
                    Text(habit.streak > 1 ? "🔥" : "😉")
                    HStack {
                        Text("\(habit.streak)")
                            .font(.title)
                        Text("days")
                    }
}
                    
                
                Spacer()
                
                if !habit.isDone {
                    DoneButtonView(habit: habit)
                }
                
            }
        }
        .onAppear {
            TM.restoreTimer()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                TM.restoreTimer()
            }
        }
    }
}

#Preview {
    DetailedHabitView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: Habit.self, inMemory: true)
}
