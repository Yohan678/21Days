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
    
    @State private var doneButtonDisabled: Bool = false
    @State private var remainingTime: Int = 0
    
    //cool down for Done Button
    let cooldownSeconds = 30
    let lastPressedKey = "lastPressedKey"
    
    var body: some View {
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
                            Text("Done")
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
    
    func startCooldown() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: lastPressedKey)
        checkCooldown()
    }
    
    func checkCooldown() {
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
    
    func startCountdown() {
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
    DoneButtonView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: Habit.self, inMemory: true)
}
