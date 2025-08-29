//
//  StreakManager.swift
//  21Days
//
//  Created by Yohan Yoon on 8/29/25.
//

import Foundation
import SwiftData

@Model
final class StreakManager {
    var lastCompleteTime: Date?
    var currentStreak: Int
    var bestStreak: Int
    
    init() {
        self.currentStreak = 0
        self.bestStreak = 0
    }
    
    func checkStreak() {
        let today = Calendar.current.startOfDay(for: Date())
        
        if let last = lastCompleteTime {
            let lastDay = Calendar.current.startOfDay(for: last)
            
            if let diff = Calendar.current.dateComponents([.day], from: lastDay, to: today).day {
                if diff == 1 {
                    currentStreak += 1
                } else if diff == 0 {
                    return
                } else {
                    currentStreak = 1
                }
            }
        } else {
            currentStreak = 1
        }
        
        bestStreak = max(bestStreak, currentStreak)
        
        lastCompleteTime = today
    }
}
