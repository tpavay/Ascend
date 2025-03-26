//
//  DateRange.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

enum DateRange: CaseIterable {
    case daily
    case weekly
    case monthly
    case yearly
    case allTime
    
    var description: String {
        switch self {
            case .daily: return "today"
            case .weekly: return "this week"
            case .monthly: return "this month"
            case .yearly: return "this year"
            case .allTime: return "all time"
        }
    }
}
