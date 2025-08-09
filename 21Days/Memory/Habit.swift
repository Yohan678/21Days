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
    let startDate: Date
    @Published var days: [Int] = []
    
    init(title: String, isDone: Bool, startDate: Date = Date.now) {
        id = UUID()
        self.title = title
        self.isDone = isDone
        self.startDate = startDate
    }
    
    func completeDay() {
        days.append(days.count + 1)
    }
}
