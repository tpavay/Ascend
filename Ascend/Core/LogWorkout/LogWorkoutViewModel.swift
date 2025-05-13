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
    // MARK: Form fields

    /// Date of the workout
    var date: Date = .now

    /// Internal representation of the workout name. Used to keep track of the user entered workout name.
    var workoutNameInternal: String = ""
    var workoutNotes: String = ""
    var duration: String = ""
    var totalSteps: String = ""
    var floorsClimbed: String = ""
    var caloriesBurned: String = ""
    var avgHeartRate: String = ""
    var maxHeartRate: String = ""

    /// Name of the workout
    var workoutName: String {
        get {
            if workoutNameInternal.isEmpty {
                return getDefaultWorkoutName()
            }
            else {
                return workoutNameInternal
            }
        }

        set {
            workoutNameInternal = newValue
        }
    }

    // MARK: Public Methods

    // MARK: Private Methods

    /// Gets the default workout name based on the time of day
    /// - Returns: String containing the default workout name relative to the time of day.
    /// Will be either "Morning", "Afternoon", "Evening", or "Night" Climb.
    private func getDefaultWorkoutName() -> String {
        return Date.getTimeOfDay().rawValue + " Climb"
    }
}
