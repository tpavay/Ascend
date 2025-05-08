//
//  LogWorkoutViewModel.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/7/25.
//

import Foundation
import Observation

@Observable
class LogWorkoutViewModel {

    /// Date of the workout
    var date: Date = .now

    /// Name of the workout
    var workoutName: String {
        get {
            return self.workoutName.isEmpty ? getDefaultWorkoutName() : self.workoutName
        }

        set {
            self.workoutName = newValue
        }
    }

//    init(date: Date, workoutName: String) {
//        self.date = date
//        self.workoutName = Date.getTimeOfDay().rawValue + ""
//    }

    /// Gets the default workout name based on the time of day
    /// - Returns: String containing the default workout name relative to the time of day.
    /// Will be either "Morning", "Afternoon", "Evening", or "Night" Climb.
    private func getDefaultWorkoutName() -> String {
        return Date.getTimeOfDay().rawValue + "Climb"
    }
}
