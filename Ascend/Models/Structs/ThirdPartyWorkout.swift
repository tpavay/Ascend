//
//  ThirdPartyWorkout.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/27/25.
//

import Foundation

struct ThirdPartyWorkout {
    var startDate: Date
    var duration: TimeInterval
    
    func toStairMasterWorkout() -> StairMasterWorkout {
        return StairMasterWorkout(workoutName: "Imported Workout", duration: duration, workoutSource: .appleFitness)
    }
}
