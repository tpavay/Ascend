import Foundation

var date = Date()

// Get the current calendar
let calendar = Calendar.current

// Get the hour of the date
let hour = calendar.component(.hour, from: date)

print("Hour of the date is: \(hour)")

print(date)

/// Function that gets a 12 hour format from a `Date` object
/// - Parameters:
///   - date: The date you want to get the 12 hour time from
///   - showPeriod: Whether or not to include the "AM" or "PM" within the string
/// - Returns: A time string with 12 hour format. If showPeriod is true the string will
/// include "AM" or  "PM" otherwise it will be excluded
func getTwelveHourFormat(from date: Date, showPeriod: Bool = true) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = showPeriod ? "h:mm a" : "h:mm"
    return dateFormatter.string(from: date)
}

getTwelveHourFormat(from: date)
getTwelveHourFormat(from: date, showPeriod: false)


/// Function that gets a time frame string that a date lies in.
/// - Parameter date: The date we want to know the time frame of
/// - Returns: A string representing the time frame. If the date was today then Today will be returned.
/// If the date was yesterday then Yesterday. If the date is tomorrow then Tomorrow will be returned.
/// Otherwise the date in MMM d, yyyy is returned.
func getTimeFrameString(from date: Date) -> String {
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
    return dateFormatter.string(from: date)
}

//func isWithinPastWeeks(_ date: Date, weeks: Int = 1) -> Bool {
//    let calendar = Calendar.current
//    let now = Date()
//    let weeksAgo = calendar.date(byAdding: .weekOfYear, value: weeks, to: now)
//    return date >= weeksAgo && date <= now
//}

func secondsToMinutesString(value: CGFloat) -> String {
    guard value >= 0 else {
        return "0"
    }
    
    return String(Int(value / 60))
}

secondsToMinutesString(value: 16000)

let lastYear = calendar.date(byAdding: .year, value: -1, to: Date())


