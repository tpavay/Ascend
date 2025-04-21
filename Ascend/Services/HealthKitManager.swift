//
//  HealthKitManager.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/21/25.
//

import HealthKit

enum HealthKitError: Error {
    case healthKitUnavailable
    case errorFetchingWorkouts
    
    var description: String {
        switch self {
        case .healthKitUnavailable: return "HealthKit Not Available"
        case .errorFetchingWorkouts: return "Error Fetching Workouts"
        }
    }
}

class HealthKitManager {
    static let shared = HealthKitManager()
    
    private let healthStore = HKHealthStore()
    
    var isHealthKitAvailable: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    func requestHealthKitWorkoutsAccess() async throws {
        guard isHealthKitAvailable else {
            throw HealthKitError.healthKitUnavailable
        }
        try await healthStore.requestAuthorization(toShare: [], read: [.workoutType()])
    }
    
    func fetchAllWorkouts() async throws -> [HKWorkout] {
        // First we use our computed property to check if health kit is available. Otherwise,
        // we will not be able to import workouts and should throw an error that the front end will handle
        guard isHealthKitAvailable else {
            throw HealthKitError.healthKitUnavailable
        }
        
        let stairStepperPredicate: NSPredicate = HKQuery.predicateForWorkouts(with: .stairClimbing)
        let stairStepperWorkoutsPredicate = HKSamplePredicate<HKWorkout>.workout(stairStepperPredicate)
        let descriptor = HKSampleQueryDescriptor(predicates: [stairStepperWorkoutsPredicate], sortDescriptors: [])
        
        do {
            var stairStepperWorkouts: [HKWorkout] = []
            let results = try await descriptor.result(for: healthStore)
            for result in results {
                stairStepperWorkouts.append(result)
            }
            
            return stairStepperWorkouts
        }
        catch {
            throw HealthKitError.errorFetchingWorkouts
        }
    }
}
