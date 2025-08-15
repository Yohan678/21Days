//
//  Habit.swift
//  21Days
//
//  Created by Yohan Yoon on 8/4/25.
//

import Foundation
import SwiftUI

class Habit: Identifiable, ObservableObject {
    var id: UUID
    @Published var title: String
    @Published var isDone: Bool
    var startDate: Date
    @Published var days: Int
    @Published var completeTime: Date
    
    init(title: String, isDone: Bool, startDate: Date = Date.now, completeTime: Date = Date.now, days: Int = 0) {
        id = UUID()
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
}
