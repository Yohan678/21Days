//
//  Habit.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import Foundation
//import SwiftUI
import SwiftData

@Model
final class Habit {
    var title: String
    var isDone: Bool
    var startDate: Date
    var days: Int
    var completeTime: Date
    var streak: Int = 0
    
    var progress: Double {
        Double(days) / 21
    }
    
    var percentText: String {
        progress.formatted(.percent.precision(.fractionLength(2)))
    }
    
    init(title: String, isDone: Bool, startDate: Date = Date.now, completeTime: Date = Date.now, days: Int = 0) {
        self.title = title
        self.isDone = isDone
        self.startDate = startDate
        self.completeTime = completeTime
        self.days = days
    }
    
    func completeDay() {
        let now = Date.now
        checkStreak(now: now)
        completeTime = now
        days += 1
        if days == 21 {
            isDone = true
        }
    }
    
    func checkStreak(now: Date) {
        let elapsed = now.timeIntervalSince(completeTime)
        
        //for testing: elapsed >= 10 && elapsed <= 60
        //for actual: elapsed >= 24 * 3600 && elapsed <= 48 * 3600
        if elapsed >= 10 && elapsed <= 60 {
            streak += 1
        } else if elapsed >= 60 { //for testing: elapsed >= 60, for actual: elapsed >= 48 * 3600
            streak = 1
        } else {
            streak = streak
        }
    }
}
