//
//  TimerManager.swift
//  21Days
//
//  Created by Yohan Yoon on 8/20/25.
//

import Foundation
import SwiftData

@Model
final class TimerManager {
    var startTime: Date?
    var duration: Int
    
    init(startTime: Date? = nil, duration: Int) {
        self.startTime = startTime
        self.duration = duration
    }
}
