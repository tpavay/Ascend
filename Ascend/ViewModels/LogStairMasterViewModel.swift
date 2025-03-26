//
//  LogStairMaster.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/14/25.
//

import Foundation
import Observation
import SwiftData

struct FormData {
    var workoutName: String
    var duration: String = "00:00"
    var totalSteps: String = "0"
}

@Observable
class LogStairMasterViewModel {
    var workoutName: String
    var duration: String
    var totalSteps: String
    
    init(modelContext: ModelContext) {
        self.workoutName = ""
        self.duration = "00:00"
        self.totalSteps = "0"
        self.workoutName = getInitialWorkoutName()
    }
    
    func logWorkout() {
        // Convert all data to properly store
        
        // Create the StairMasterWorkout model from the converted data
        
        // Insert the model into modelContext
    }
    
    private func getInitialWorkoutName() -> String {
        switch Date.getTimeOfDay() {
        case .morning:
            return "Morning Climb"
        case .afternoon:
            return "Afternoon Climb"
        case .evening:
            return "Evening Climb"
        case .night:
            return "Late Night Climb"
        }
    }
}
