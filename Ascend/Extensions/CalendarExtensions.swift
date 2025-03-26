//
//  CalendarExtensions.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import Foundation

/// Extensions to the Calendar class provided by Foundation
extension Calendar {
  
  /// startOfToday
  /// - Returns: `Date` for the start of the current day
  static func startOfToday() -> Date {
    Calendar.current.startOfDay(for: Date())
  }
  
  /// endOfToday
  /// - Returns: `Date` for the end of the current day
  static func endOfToday() -> Date {
    Calendar.current.date(byAdding: DateComponents(hour: 23, minute: 59, second: 59), to:  Calendar.current.startOfDay(for: Date()))!
  }
  
  /// startOfTomorrow
  /// - Returns: `Date` for start of tomorrow
  static func startOfTomorrow() -> Date {
    Calendar.current.date(byAdding: DateComponents(hour: 24), to:  Calendar.current.startOfDay(for: Date()))!
  }
  
  /// endOfTomorrow
  /// - Returns: `Date` for the end of tomorrow
  static func endOfTomorrow() -> Date {
    Calendar.current.date(byAdding: DateComponents(hour: 47, minute: 59, second: 59), to:  Calendar.current.startOfDay(for: Date()))!
  }
  
  /// afterTomorrow
  /// - Returns: `Date` for the start of the day after tomorrow
  static func afterTomorrow() -> Date {
    Calendar.current.date(byAdding: DateComponents(hour: 48, minute: 0, second: 0), to:  Calendar.current.startOfDay(for: Date()))!
  }
}
