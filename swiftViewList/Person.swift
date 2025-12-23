//
//  Person.swift
//  swiftViewList
//
//  Created by Deepak T G on 14/10/25.
//

import SwiftData
import Foundation

@Model
class Person {
    var name: String
    var age: Int
    var desc: String
    
    init(name: String, age: Int, desc: String) {
        self.name = name
        self.age = age
        self.desc = desc
    }
}
