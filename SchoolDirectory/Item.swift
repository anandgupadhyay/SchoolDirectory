//
//  Item.swift
//  SchoolDirectory
//
//  Created by Anand Upadhyay on 31/01/25.
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
