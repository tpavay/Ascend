//
//  ImportWorkoutsView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/21/25.
//

import SwiftUI
import HealthKit

struct ImportWorkoutsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var workouts: [StairMasterWorkout] = []
    let healthKitManager = HealthKitManager.shared
    @State private var isLoading: Bool = false
    @State var isError: Bool = false
    @State var errorString: String = ""
    @State var errorDescription: String = ""
    @State var hkWorkouts: [HKWorkout] = []
    var body: some View {
        NavigationStack {
            VStack {
                if isLoading {
                    Text("Loading workouts...")
                }

                if isError {
                    errorContent
                }
                
                if !hkWorkouts.isEmpty {
                    ForEach(hkWorkouts, id: \.self) { workout in
                        Text("Duration \(workout.duration)")
                        Text("ActivityType\(workout.workoutActivityType)")
                        Divider()
                    }
                }
            }
            .navigationTitle("Import Workouts")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                do {
                    isLoading = true
                    try await healthKitManager.requestHealthKitWorkoutsAccess()
                    let importedWorkouts = try await healthKitManager.fetchAllWorkouts()
                    isLoading = false
                    
                    for workout in importedWorkouts {
                        hkWorkouts.append(workout)
                    }
                }
                catch let error as HealthKitError {
                    switch error {
                    case .healthKitUnavailable:
                        errorString = HealthKitError.healthKitUnavailable.description
                        errorDescription = "This device doesn't support HealthKit integration, which means workout importing is unavailable."
                    case .errorFetchingWorkouts:
                        errorString = HealthKitError.errorFetchingWorkouts.description
                        errorDescription = "There was an error fetching stair stepper workouts from health kit."
                    }
                    isError = true
                }
                catch {
                    errorString = "Unexpected error occurred."
                    isError = true
                }
            }
        }
    

    }
    
    private var errorButton: some View {
        Text("Return to Dashboard")
            .onTapGesture {
                dismiss()
            }
    }
    
    private var errorContent: some View {
        VStack {
            ErrorView(errorText: errorString, errorDescription: errorDescription)
            CustomTextButton(
                buttonText: "Return to Dashboard",
                buttonTextColor: .white,
                fillColor: .accentPrimary,
                action: { dismiss()})
        }
        .buttonStyle(.plain)
        .padding()
    }
}

#Preview {
    ImportWorkoutsView()
}
