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
    
    @State private var doneButtonDisabled = false
    @State private var remainingTime = 0
    
    //cool down for Done Button
    let cooldownSeconds = 30
    let lastPressedKey = "lastPressedTime"
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                let completeDate = habit.startDate.addingTimeInterval(3600 * 24 * 21)
                
                Text("\(habit.startDate, style: .date) ~ \(completeDate, style: .date)")
                    .bold()
                    .navigationTitle(habit.title)
                    .navigationBarTitleDisplayMode(.inline)
                
                Spacer()

                Text("Progress & Streaks")
                    .padding()
                    .font(.title)
                    .bold()
                
                Text("\(habit.percentText)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                ProgressView(value: habit.progress)
                    .padding()
                
                //Daily Streak Logic
                
                if #available(iOS 16.0, *) {
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
                } else {
                    Text("It is available devices with iOS 16 or more")
                }
                
                
                
                
                Spacer()
                
                HStack {
                    VStack {
                        if doneButtonDisabled {
                            Text("Time Left: \(remainingTime)")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        
                        Button {
                            habit.completeDay()
                            startCooldown()
                        } label: {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.blue)
                                .frame(width: 100, height: 50)
                                .overlay(
                                    Text(doneButtonDisabled ? "Wait \(remainingTime)s" : "DONE")
                                        .foregroundColor(.white)
                                        .bold()
                                )
                        }
                        .padding()
                        .disabled(doneButtonDisabled)
                    }
                    
                    //for testing!
                    Button { remainingTime = 0 } label: {
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
        .onAppear {
            checkCooldown()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                checkCooldown()
            }
        }
    }
    
    private func startCooldown() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: lastPressedKey)
        checkCooldown()
    }
    
    private func checkCooldown() {
        if let lastPressed = UserDefaults.standard.object(forKey: lastPressedKey) as? Date {
            let elapsed = Int(Date().timeIntervalSince(lastPressed))
            let remaining = cooldownSeconds - elapsed
            
            if remaining > 0 {
                doneButtonDisabled = true
                remainingTime = remaining
                startCountdown()
            } else {
                doneButtonDisabled = false
                remainingTime = 0
            }
        }
    }
    
    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                doneButtonDisabled = false
                timer.invalidate()
            }
        }
    }
}

#Preview {
    DetailedHabitView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: Habit.self, inMemory: true)
}
