//
//  DateExtensions.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//
import Foundation

extension Date {
    /// Creates a Date from specified month, day, and year components.
    /// - Parameters:
    ///   - month: The month (1-12)
    ///   - day: The day of the month
    ///   - year: The year (e.g., 2025)
    /// - Returns: A Date object representing the specified date
    ///
    /// Note: This function force-unwraps the result, assuming valid date components are provided.
    static func from(month: Int, day: Int, year: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
    
    /// Determines the time of day (morning, afternoon, evening, or night) based on the current hour.
    /// - Returns: A TimeOfDay enum value representing the current period of the day
    ///
    /// Time ranges:
    /// - Morning: 12 AM to 11:59 AM (0-11)
    /// - Afternoon: 12 PM to 4:59 PM (12-16)
    /// - Evening: 5 PM to 8:59 PM (17-20)
    /// - Night: 9 PM to 11:59 PM (21-23)
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
    
    /// Function that gets a 12 hour format from a `Date` object
    /// - Parameters:
    ///   - date: The date you want to get the 12 hour time from
    ///   - showPeriod: Whether or not to include the "AM" or "PM" within the string
    /// - Returns: A time string with 12 hour format. If showPeriod is true the string will include "AM" or  "PM" otherwise it will be excluded
    static func getTwelveHourFormat(from date: Date, showPeriod: Bool = true) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = showPeriod ? "h:mm a" : "h:mm"
        return dateFormatter.string(from: date)
    }
    
    /// Function that gets a time frame string that a date lies in.
    /// - Parameter date: The date we want to know the time frame of
    /// - Returns: A string representing the time frame. If the date was today then Today will be returned.
    /// If the date was yesterday then Yesterday. If the date is tomorrow then Tomorrow will be returned.
    /// Otherwise the date in MMM d, yyyy is returned.
    static func getTimeFrameString(from date: Date) -> String {
        let calendar = Calendar.current
        
        if (calendar.isDateInToday(date)) {
            return "Today"
        }
        
        if (calendar.isDateInYesterday(date)) {
            return "Yesterday"
        }
        
        if (calendar.isDateInTomorrow(date)) {
            return "Tomorrow"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        // If date is within the past week, and before yesterday: output the weekday
        // for instance "Wednesday"
        guard let oneWeekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: .now) else {
            // Fall back to default date if error getting one week ago
            return dateFormatter.string(from: date)
        }
        
        if (date > oneWeekAgo  && date < Date()) {
            return date.formatted(Date.FormatStyle().weekday(.wide))
        }
        
        return dateFormatter.string(from: date)
    }
}

/// Represents different periods of the day based on the hour.
enum TimeOfDay: String {
    /// From 12 AM to 11:59 AM
    case morning = "Morning"
    
    /// From 12 PM to 4:59 PM
    case afternoon = "Afternoon"
    
    /// From 5 PM to 8:59 PM
    case evening = "Evening"
    
    /// From 9 PM to 11:59 PM
    case night = "Night"
}
