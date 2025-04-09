//
//  WorkoutSource.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/8/25.
//

import Foundation

enum WorkoutSource: String, Codable {
    case manualEntry = "manual"
    case appleFitness = "apple"
    case strava = "strava"
    
    var description: String {
        switch self {
        case .manualEntry: return "Manual"
        case .appleFitness: return "Apple Fitness"
        case .strava: return "Strava"
        }
    }
}
