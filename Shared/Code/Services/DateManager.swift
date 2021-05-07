//
//  DateManager.swift
//  Everyday-Notes
//
//  Created by MANAS VIJAYWARGIYA on 02/05/21.
//

import Foundation

struct DateManager {
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter
    }()
    
    
    func getCurrentDate() -> String {
        return dateFormatter.string(from: Date())
    }
    
    func getCurrentDay() -> String {
        return dayFormatter.string(from: Date())
    }
}
