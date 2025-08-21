//
//  DoneButtonView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/18/25.
//

import SwiftUI
import SwiftData

struct DoneButtonView: View {
    @Environment(\.modelContext) private var modelContext
    
    var habit: Habit
    
    
    @StateObject private var TM = TimerManager()
    
    var body: some View {
        HStack {
            VStack {
                if TM.doneButtonDisabled {
                    Text("Time Left: \(TM.remainingSeconds)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Button {
                    habit.completeDay()
                    TM.startCooldown(seconds: 20) // testing seconds: 20
                    MainView(habit: habit).scheduleNotfication(title: "Testing Notification Title", body: "Testing Notification Body", after: Double(20))
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.blue)
                        .frame(width: 100, height: 50)
                        .overlay(
                            Text("Done")
                                .foregroundColor(.white)
                                .bold()
                        )
                }
                .padding()
                .disabled(TM.doneButtonDisabled)
            }
            
            //for testing!
            Button {
                TM.remainingSeconds = 0
                TM.stopTimer()
            } label: {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.blue)
                    .frame(width: 100, height: 50)
                    .overlay(
                        Text("RESET")
                            .foregroundColor(.white)
                            .bold()
                    )
                
            }
        }
    }
}

#Preview {
    DoneButtonView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: Habit.self, inMemory: true)
}
