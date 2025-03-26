//
//  DateExtensions.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//
import Foundation

extension Date {
    static func from(month: Int, day: Int, year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
    
    static func getTimeOfDay() -> TimeOfDay {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12:
            return .morning
        case 12..<17:
            return .afternoon
        case 17..<21:
            return .evening
        default:
            return .night
        }
    }
}

enum TimeOfDay: String {
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
}
