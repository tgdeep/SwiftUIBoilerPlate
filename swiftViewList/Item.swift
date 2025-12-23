//
//  Item.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
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
