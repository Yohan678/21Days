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
    
    init(title: String, isDone: Bool, startDate: Date = Date.now, completeTime: Date = Date.now, days: Int = 0) {
        self.title = title
        self.isDone = isDone
        self.startDate = startDate
        self.completeTime = completeTime
        self.days = days
    }
    
    func completeDay() {
        days += 1
        if days == 21 {
            isDone = true
        }
    }
    
    var progress: Double {
        Double(days) / 21
    }
    
    var percentText: String {
        progress.formatted(.percent.precision(.fractionLength(2)))
    }
    

}
