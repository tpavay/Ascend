//
//  DateRange.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

import SwiftUI

/// Enum that represents a date range and it's associated descriptions
enum DateRange: CaseIterable {
    case weekly
    case monthly
    case yearly
    case allTime
    
    /// Short description used to describe the date range
    var description: String {
        switch self {
            case .weekly: return "weekly"
            case .monthly: return "monthly"
            case .yearly: return "yearly"
            case .allTime: return "all time"
        }
    }
    
    /// Long description used to describe the date range
    var longDescription: String {
        switch self {
            case .weekly: return "this week"
            case .monthly: return "this month"
            case .yearly: return "this year"
            case .allTime: return "all time"
        }
    }
    
    /// Color associated with the date range
    var color: Color {
        switch self {
        case .weekly: return .accentPrimary
        case .monthly: return .accentSecondary
        case .yearly: return .accentTertiary
        case .allTime: return .customBlue
        }
    }
}
