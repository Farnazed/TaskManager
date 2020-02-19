//
//  Task.swift
//  TodoList
//
//  Created by farnaz on 2020-01-28.
//  Copyright © 2020 farnaz. All rights reserved.
//

import Foundation
import SwiftUI
struct Task: Hashable, Codable , Identifiable {
    var id : Int
    var creationDate: String
    var creationDateYear: String
    var creationDateMonth : String
    var creationDateDay: String
    var dueDate : String
    var time: String
    var title : String
    var description : String
    var priority : Int
    var isDone : Bool
    init(id: Int, creationDate: String, creationDateYear: String, creationDateMonth: String, creationDateDay: String, dueDate: String, time: String, title: String, description: String, priority: Int, isDone : Bool) {
        self.id = id
        self.creationDate = creationDate
        self.creationDateYear = creationDateYear
        self.creationDateMonth = creationDateMonth
        self.creationDateDay = creationDateDay
        self.dueDate = dueDate
        self.time = time
        self.title = title
        self.description = description
        self.priority = priority
        self.isDone = isDone
    }
    
    
    
}
