//
//  WorkoutDetailView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftUI

struct WorkoutFormData {
    var workoutName: String
//    var workoutDate: Date
//    var duration: String
//    var floorsClimbed: String?
//    var totalSteps: String?
//    var caloriesBurned: String?
//    var avgHeartRate: String?
//    var maxHeartRate: String?
//    var workoutSource: String
//    var notes: String?
    
    init() {
        workoutName = "Workout"
    }
    
    init(from workout: StairMasterWorkout) {
        workoutName = workout.workoutName
    }
}

struct WorkoutDetailView: View {
    /// Environment color scheme used to ensure the form background matches the background of the device
    @Environment(\.colorScheme) private var colorScheme
    
    @State var workoutData: WorkoutFormData
    @FocusState private var focusedField: LogStairMasterWorkoutFormField?
    
    var body: some View {
        Form {
            LabeledTextField(label: "Workout Name", placeholder: "", text: $workoutData.workoutName, field: .workoutName, focusedField: $focusedField)
        }
        .scrollContentBackground(.hidden) // Hide the silly scroll background
        .background(colorScheme == .light ? .clear : .darkModeFormBackground)
        
    }
}

#Preview("Light Mode") {
    @Previewable @State var sampleWorkoutData: WorkoutFormData = WorkoutFormData()
    
    WorkoutDetailView(workoutData: sampleWorkoutData)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    @Previewable @State var sampleWorkoutData: WorkoutFormData = WorkoutFormData()
    
    WorkoutDetailView(workoutData: sampleWorkoutData)
        .preferredColorScheme(.dark)
}
