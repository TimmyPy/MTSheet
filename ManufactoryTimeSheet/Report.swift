//
//  File.swift
//  ManufactoryTimeSheet
//
//  Created by Artem Denisov  on 14-07-2024.
//

import Foundation
import SwiftData

@Model
final class Report {
    var created_at: Date
    var start: Date?
    var end: Date?
    var lunch_duration: Int8?
    
    init(created_at: Date) {
        self.created_at = created_at
    }
    
    func calculateWorkingHours() -> String {
        let interval = (end?.timeIntervalSince(start!))! / 60
        
        let totalMinutes = Int(interval) - Int(lunch_duration!)
        
        
        if totalMinutes <= 0 {
            return "0 minutes"
        } else if totalMinutes < 60 {
            return "\(totalMinutes) minutes"
        }
        else {
            let hours = totalMinutes / 60
            let minutes = totalMinutes % 60
            return "\(hours) hours \(minutes) minutes"
        }
    }
}
