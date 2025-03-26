//
//  Workout.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/10/25.
//

import Foundation
import SwiftData

@Model
class StairMasterWorkout {
    /// Unique identifier of a stair master workout
    var id: UUID

    /// Name of the stair master workout. Cannot be null
    var workoutName: String

    /// Date the stair master workout occurred. Cannot be null
    var date: Date
    
    /// The length of the stair master workout in seconds. Cannot be null.
    var duration: TimeInterval

    /// Number of floors climbed during the stair master workout indicated on the Stair Master machine. Can be null
    var floorsClimbed: Int?

    /// Total number of steps climbed during the stair master workout indicated on the stair master machine. Can be null
    var totalSteps: Int?

    /// Number of calories burned indicated by stair master machine or fitness wearable. Can be null.
    var caloriesBurned: Double?

    /// Average heart rate during the stair master workout indicated by fitness wearable. Can be null.
    var avgHeartRate: Double?

    /// Max heart rate during the stair master workout indicated by fitness wearable. Can be null.
    var maxHeartRate: Double?

    /// Intensity of the workout. Can be null.
    //var intensity: WorkoutIntensityLevel?

    /// Notes describing the workout.
    var notes: String

    init(id: UUID = UUID(),
        workoutName: String,
        date: Date = Date(),
        duration: TimeInterval,
        floorsClimbed: Int?,
        totalSteps: Int?,
        caloriesBurned: Double?,
        avgHeartRate: Double?,
        maxHeartRate: Double?,
        //intensity: WorkoutIntensityLevel?,
        notes: String = "") {
        self.id = id
        self.workoutName = workoutName
        self.date = date
        self.duration = duration
        self.floorsClimbed = floorsClimbed
        self.totalSteps = totalSteps
        self.caloriesBurned = caloriesBurned
        self.avgHeartRate = avgHeartRate
        self.maxHeartRate = maxHeartRate
        //self.intensity = intensity
        self.notes = notes
    }
}
