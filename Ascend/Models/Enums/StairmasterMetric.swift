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
            case .stepsClimbed: return "Steps"
            case .floorsClimbed: return "Floors"
            case .caloriesBurned: return "Calories"
            case .durationClimbed: return "Duration"
        }
    }
    
    var imageText: String {
        switch self {
        case .stepsClimbed: return "figure.stair.stepper"
        case .floorsClimbed: return "building"
        case .caloriesBurned: return "flame"
        case .durationClimbed: return "clock"
        }
    }
}
