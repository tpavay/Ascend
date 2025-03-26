//
//  StairmasterMetric.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

/// An enum used to represent the different metrics provided by a Stairmaster
enum StairmasterMetric: CaseIterable {
    case stepsClimbed
    case floorsClimbed
    case caloriesBurned
    case durationClimbed
    
    var description: String {
        switch self {
            case .stepsClimbed: return "Steps climbed"
            case .floorsClimbed: return "Floors climbed"
            case .caloriesBurned: return "Calories burned"
            case .durationClimbed: return "Duration climbed"
        }
    }
}
