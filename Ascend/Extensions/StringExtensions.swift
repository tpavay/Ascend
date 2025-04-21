//
//  StringExtensions.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/2/25.
//
import Foundation

extension String {
    /// Converts a string in the format "HH:MM:SS", "MM:SS", or "SS" to a TimeInterval in seconds.
    /// - Returns: A TimeInterval representing the total seconds.
    ///
    /// Examples:
    /// - "1:30" returns 90.0 (1 minute, 30 seconds)
    /// - "2:30:15" returns 9015.0 (2 hours, 30 minutes, 15 seconds)
    /// - "45" returns 45.0 (45 seconds)
    /// - Invalid formats return 0.0
    func toTimeInterval() -> TimeInterval {
        // Remove any non-digit and non-colon characters
        let cleanString = self.filter { "0123456789:".contains($0) }
        let components = cleanString.components(separatedBy: ":")
        
        var seconds: TimeInterval = 0
        
        switch components.count {
        case 1: // Only seconds
            if let sec = Double(components[0]) {
                seconds = sec
            }
        case 2: // Minutes:Seconds
            if let min = Double(components[0]),
               let sec = Double(components[1]) {
                seconds = (min * 60) + sec
            }
        case 3: // Hours:Minutes:Seconds
            if let hr = Double(components[0]),
               let min = Double(components[1]),
               let sec = Double(components[2]) {
                seconds = (hr * 3600) + (min * 60) + sec
            }
        default:
            break
        }
        
        return seconds
    }
    
    /// Converts seconds to a string representation of minutes.
    /// - Parameter seconds: The number of seconds to convert.
    /// - Returns: A string representing the total minutes (rounded down).
    ///
    /// Note: This function truncates decimal values and returns only whole minutes.
    /// If the input is negative, it returns "0".
    ///
    /// Examples:
    /// - 90.0 seconds returns "1" (1 minute)
    /// - 119.9 seconds returns "1" (1 minute, truncated)
    /// - 120.0 seconds returns "2" (2 minutes)
    static func secondsToMinutesString(seconds: CGFloat) -> String {
        guard seconds >= 0 else {
            return "0"
        }
        
        return String(Int(seconds / 60))
    }
    
    static func convertDurationsInSecondsToHoursMinutesSecondsString(from duration: Int) -> String {
        if duration <= 0 {
            return "--"
        }
        
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        
        var components: [String] = []
        
        if hours > 0 {
            components.append(getTimeMetricText(duration: hours, timeMetric: .hour))
        }
        
        if minutes > 0 {
            components.append(getTimeMetricText(duration: minutes, timeMetric: .minute))
        }
        
        if seconds > 0 && (hours == 0) { // Only show seconds if less than an hour
            components.append(getTimeMetricText(duration: seconds, timeMetric: .second))
        }
        
        return components.joined(separator: " ")
    }
}

private func getTimeMetricText(duration: Int, timeMetric: TimeMetric) -> String {
    return "\(duration)\(timeMetric.shortText)"
}

enum TimeMetric: String {
    case second
    case minute
    case hour
    
    var shortText: String {
        switch self {
        case .second: return "s"
        case .minute: return "m"
        case .hour: return "h"
        }
    }
}
