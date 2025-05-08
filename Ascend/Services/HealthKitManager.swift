//
//  HealthKitManager.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/21/25.
//

import HealthKit

enum HealthKitError: Error {
    case healthKitUnavailable
    case authorizationNotGranted
    case errorFetchingWorkouts
    
    var errorText: String {
        switch self {
        case .healthKitUnavailable: return "HealthKit Not Available"
        case .errorFetchingWorkouts: return "Error Fetching Workouts"
        case .authorizationNotGranted: return "Authorization Denied"
        }
    }
    
    var description: String {
        switch self {
        case .healthKitUnavailable: return "This device does not support HealthKit integration. Therefore workout importing is unavailable."
        case .errorFetchingWorkouts: return ""
        case .authorizationNotGranted: return ""
        }
    }
}

class HealthKitManager {
    /// Single HealthKitManager instance that can be accessed throughout the app
    static let shared = HealthKitManager()
    
    /// Private `HKHealthStore` instance used to query and update the user's HealthKit data
    private let healthStore = HKHealthStore()
    
    /// Anchor used to remember the position of the last time we perform a long running query for stair stepper workouts
    var stairStepperAnchor: HKQueryAnchor?
    
    /// Task used to cancel the stair stepper monitoring task
    var stairStepperTask: Task<Void, Never>?
    
    /// Private initializer for singleton pattern
       private init() {
           // Load the saved anchor from persistent storage if available
           loadSavedAnchor()
       }
    
    /// Whether or not the user's device is compatible with HealthKit
    var isHealthKitAvailable: Bool {
        return HKHealthStore.isHealthDataAvailable()
    }
    
    /// Function that requests authorization to read, update, or read/update the provided HealthKit sample types
    /// - Parameters:
    ///   - toShare: The HealthKit types to request authorization to update
    ///   - read: The HealthKit types to request authorization to read
    func requestAuthorization(toShare: Set<HKSampleType>, read: Set<HKSampleType>) async throws {
        try await healthStore.requestAuthorization(toShare: toShare, read: read)
    }
    
    func monitorStairStepperWorkoutsInPastMonth() async throws -> AsyncStream<[HKWorkout]> {
        /*
         What does this need to do?
         
         1. We need to ensure that we have access to health kit in the first place. If
         we don't then we should never start this task because there would never be anything to
         read from.
         
         2. We need to requestAuthorization for access to *read* workouts from the user's HealthKit store.
         
            - Note: Apple does not provide us access to whether or not the user authorized us to use health kit or not as this is a privacy issue. So, I think we should monitor regardless because we cannot know. And then if no workouts are found we can cancel the task.
         
         3. Once we know that HealthKit is available and have requested authorization to read
         the users workouts we need to create our long running query. This will be an HKAnchoredObjectQueryDescriptor
         because we will need to utilize the anchor to keep track of when we last queried for workouts. This
         way, we will only get workouts that have been updated (newly created, deleted, or updated).
            - Note: We use the Descriptor rather than the Query because this is the Swift concurrency version
         and we want to use async await.
         
            1. Create our predicate for the stair stepper workout type. This tells the query that we want
         stair stepper workouts from HealthKit and to filter out all other types. Additionally, create a predicate
         that only retrieves the workouts from the past month.
         
        2. Create our query descriptor by passing this predicate to the workout
     
        3. Start the asynchronous long running query by calling resultsFor using our healthStore instance.
         
        4. Await the results using a for try await look on the results and iterate over each result.
         
        5. Get the added workouts and the deleted workouts from results.
         
         6. Update the anchor so that we only pull updated workouts from that point forward next time the query is performed.
         */
        
        
        // Check if health kit is available on this device
        guard isHealthKitAvailable else {
            throw HealthKitError.healthKitUnavailable
        }
        
        // Request authorization to read workout data
        // We only need to read workout data so toShare is empty
        try await requestAuthorization(toShare: [], read: [.workoutType()])
        
        return AsyncStream<[HKWorkout]> { continuation in
            
            self.stairStepperTask = Task {
                do {
                    // 1. Create predicate to filter stair stepper workouts within the last month
                    let queryPredicate = createStairStepperWorkoutsPredicate()
                    
                    // 2. Create the asynchronous query descriptor using our predicate and current anchor
                    let queryDescriptor: HKAnchoredObjectQueryDescriptor<HKWorkout> = HKAnchoredObjectQueryDescriptor(
                        predicates: [createStairStepperWorkoutsPredicate()],
                        anchor: self.stairStepperAnchor
                    )
                    
                    // 3. Execute the query and get the results as they arrive
                    for try await result in queryDescriptor.results(for: healthStore) {
                        // Get the workouts that were added since our last query
                        let addedStairStepperWorkouts = result.addedSamples
                        
                        // Update our anchor with the new one from results
                        self.stairStepperAnchor = result.newAnchor
                        
                        // Persist the new anchor
                        
                        // If new workouts were added, emit them to the stream
                        if !addedStairStepperWorkouts.isEmpty {
                            continuation.yield(addedStairStepperWorkouts)
                        }
                        
                        // Check if the task has been cancelled. If so, stop the stream
                        if Task.isCancelled {
                            continuation.finish()
                            break
                        }
                    }
                    
                    // Mark the stream as finished
                    continuation.finish()
                }
                catch {
                    print("Error monitoring stair stepper workouts: \(error.localizedDescription)")
                    continuation.finish()
                }
            }
            
            // Set up cleanup when the stream is terminated
            continuation.onTermination = { _ in
                self.stairStepperTask?.cancel()
            }
        }
    }
    
    /// Creates predicates to be used to filter HealthKit workout data for stair stepper workouts within the last month.
    ///
    /// - Returns: An `HKSamplePredicate` that will filter HealthKit workouts to retrieve only stair stepper workouts
    /// within the past month from today.
    private func createStairStepperWorkoutsPredicate() -> HKSamplePredicate<HKWorkout> {
        // Only retrieve stair stepper workouts
        let stairStepperPredicate: NSPredicate = HKQuery.predicateForWorkouts(with: .stairClimbing)
        
        // Only retrieve samples within the past month
        let pastMonthPredicate: NSPredicate = HKQuery.predicateForSamples(
            withStart: Calendar.current.date(byAdding: .month, value: -1, to: .now)!,
            end: .now,
            options: [.strictStartDate, .strictEndDate]
        )
        
        // Combine the two predicates to be used to filter HK workouts
        let stairStepperInPastMonth: NSCompoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [stairStepperPredicate, pastMonthPredicate])
        
        return HKSamplePredicate.workout(stairStepperInPastMonth)
    }
    
    /// Saves the current workout query anchor to UserDefaults for persistence
        private func saveAnchor() {
            guard let anchor = stairStepperTask else { return }
            
            do {
                // Archive the anchor object to Data
                let anchorData = try NSKeyedArchiver.archivedData(
                    withRootObject: anchor,
                    requiringSecureCoding: true
                )
                
                // Save the data to UserDefaults
                UserDefaults.standard.set(anchorData, forKey: "stairStepperWorkoutAnchor")
            } catch {
                print("Error saving workout query anchor: \(error)")
            }
        }
        
        /// Loads a previously saved workout query anchor from UserDefaults
        private func loadSavedAnchor() {
            guard let anchorData = UserDefaults.standard.data(forKey: "stairStepperWorkoutAnchor") else {
                return
            }
            
            do {
                // Unarchive the anchor from the saved Data
                if let anchor = try NSKeyedUnarchiver.unarchivedObject(
                    ofClass: HKQueryAnchor.self,
                    from: anchorData
                ) {
                    self.stairStepperAnchor = anchor
                }
            } catch {
                print("Error loading workout query anchor: \(error)")
            }
        }
        
        /// Cancels any ongoing workout monitoring
        func stopMonitoring() {
            stairStepperTask?.cancel()
            stairStepperTask = nil
        }
}
