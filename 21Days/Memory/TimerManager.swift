//
//  TimerManager.swift
//  21Days
//
//  Created by Yohan Yoon on 8/20/25.
//

import Foundation

class TimerManager: ObservableObject {
    @Published var remainingSeconds: Int = 0
    private var timer: Timer?
    private var endTime: Date?
    @Published var doneButtonDisabled: Bool = false
    
    func startCooldown(seconds: Int) {
        doneButtonDisabled = true
        endTime = Date().addingTimeInterval(TimeInterval(seconds))
        
        UserDefaults.standard.set(endTime, forKey: "endTime")
        UserDefaults.standard.set(doneButtonDisabled, forKey: "doneButtonDisabled")
        
        runTimer()
    }
    
    func restoreTimer() {
        if let savedEndTime = UserDefaults.standard.object(forKey: "endTime") as? Date {
            let isTimerRunning = UserDefaults.standard.bool(forKey: "doneButtonDisabled")
            doneButtonDisabled = isTimerRunning
            
            print("done button disabled: \(doneButtonDisabled)")
            
            endTime = savedEndTime
            
            print("remaining time: \(remainingSeconds)")
            runTimer()
        }
    }
    
    func runTimer() {
        timer?.invalidate()
        updateRemainingTime()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateRemainingTime()
        }
    }
    
    func updateRemainingTime() {
        guard let endTime = endTime else { return }
        
        let now = Date()
        let diff = Int(endTime.timeIntervalSince(now))
        
        if diff <= 0 {
            remainingSeconds = 0
            stopTimer()
            UserDefaults.standard.removeObject(forKey: "endTime")
        } else {
            remainingSeconds = diff
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        doneButtonDisabled = false
    }
}
