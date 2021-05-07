//
//  Task.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import Foundation

struct Task: Codable, Identifiable, Hashable {
    let id: Int
    let taskName: String
    var taskCompleted: Bool
    let createdDate: Date
    
    init(id: Int, taskName: String, taskCompleted: Bool, createdDate: Date) {
        self.id = id
        self.taskName = taskName
        self.taskCompleted = taskCompleted
        self.createdDate = createdDate
    }
    
    init() {
        id = 0
        taskName = ""
        taskCompleted = false
        createdDate = Date()
    }
}
