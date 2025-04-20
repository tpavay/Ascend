//
//  DateRange.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

import SwiftUI

enum DateRange: CaseIterable {
    case weekly
    case monthly
    case yearly
    case allTime
    
    var description: String {
        switch self {
            case .weekly: return "weekly"
            case .monthly: return "monthly"
            case .yearly: return "yearly"
            case .allTime: return "all time"
        }
    }
    
    var longDescription: String {
        switch self {
            case .weekly: return "this week"
            case .monthly: return "this month"
            case .yearly: return "this year"
            case .allTime: return "all time"
        }
    }
    
    var color: Color {
        switch self {
        case .weekly: return .accentPrimary
        case .monthly: return .accentSecondary
        case .yearly: return .accentTertiary
        case .allTime: return .customBlue
        }
    }
}
