//
//  Item.swift
//  ManufactoryTimeSheet
//
//  Created by Artem Denisov  on 14-07-2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
