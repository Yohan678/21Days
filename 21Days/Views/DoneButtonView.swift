//
//  DoneButtonView.swift
//  21Days
//
//  Created by Yohan Yoon on 8/18/25.
//

import SwiftUI
import SwiftData

struct DoneButtonView: View {
    @Environment(\.modelContext) private var context
    @Query private var timers: [TimerManager]
    
    var habit: Habit
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var remainingTime: Int = 0
    @State var isRunning: Bool = false
    var body: some View {
        HStack {
            VStack {
                if isRunning {
                    Text("Time left: \(remainingTime)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Button {
                    habit.completeDay()
//                    habit.streakManager.checkStreak()
                    startTimer()
                } label: {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(isRunning ? .teal : .blue)
                        .frame(width: 100, height: 50)
                        .overlay(
                            Image(systemName: isRunning ? "lock.fill" : "checkmark")
                                .foregroundColor(.white)
                                .bold()
                        )
                }
                .padding()
                .disabled(isRunning)
                .shadow(radius: 5)
            }
            
            //for testing!
            Button {
                
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
        .onAppear {
            loadTimer()
        }
        .onReceive(timer) { _ in
            updateRemainingTime()
        }
    }
    
    func startTimer() {
        let entity: TimerManager
        if let existing = timers.first {
            entity = existing
        } else {
            entity = TimerManager(duration: 60) //60 seconds
            context.insert(entity)
        }
        
        entity.startTime = Date()
        try? context.save()
        isRunning = true
    }
    
    func loadTimer() {
        guard let entity = timers.first else { return }
        if let startTime = entity.startTime {
            let elapsed = Int(Date().timeIntervalSince(startTime))
            remainingTime = max(entity.duration - elapsed, 0)
            isRunning = remainingTime > 0
        }
    }
    
    func updateRemainingTime() {
        guard isRunning, let entity = timers.first, let startTime = entity.startTime else { return }
        let elapsed = Int(Date().timeIntervalSince(startTime))
        remainingTime = max(entity.duration - elapsed, 0)
        
        if remainingTime == 0 {
            isRunning = false
            entity.startTime = nil
            try? context.save()
        }
    }
}

#Preview {
    DoneButtonView(habit: Habit(title: "Dummy Title", isDone: false))
        .modelContainer(for: Habit.self, inMemory: true)
}
