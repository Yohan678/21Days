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
    var comepleteTime: Date?
    var streak: Int
    
    init(completeTime: Date? = nil, streak: Int) {
        self.comepleteTime = completeTime
        self.streak = streak
    }
    
    
    
}
