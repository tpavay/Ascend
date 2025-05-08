//
//  ImportWorkoutsCellView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/23/25.
//

import SwiftUI

import SwiftUI

/// A cell that is used to display workouts from a third party, such as Apple Fitness, that can be imported into the app
struct ImportWorkoutsCellView: View {
    /// Model context used to save (import) the workout into our application
    @Environment(\.modelContext) private var modelContext
    var workout: ThirdPartyWorkout

    /// Computed property that converts the workout date into a date string to be displayed within the cell. This is created here but shouldn't change so doesn't need to be an @State property
    var dateDisplayText: String {
        return Date.getTimeFrameString(from: workout.startDate)
    }
    
    var workoutStartTimeDisplayText: String {
        return Date.getTwelveHourFormat(from: workout.startDate)
    }

    /// Whether or not this workout has already been imported. This will need to change if the user imports the workout and the source of truth is here so this is a state property.
    @State var isImported: Bool = false
    
    @State var isImporting: Bool = false

    var body: some View {
        HStack() {
            stairStepperImage
            displayText
            Spacer()
            importButton
        }
        .padding()
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color(UIColor.label).opacity(0.3), radius: 4)
        )
        .padding()
    }

    private var stairStepperImage: some View {
        Image(systemName: "figure.stair.stepper")
            .resizable()
            .scaledToFit()
            .frame(width: 15)
    }

    private var displayText: some View {
        HStack {
            Text(dateDisplayText)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(Color(UIColor.label))
            Text(workoutStartTimeDisplayText)
                .font(.caption)
        }
       
    }

    private var importButton: some View {
        Button {
            saveWorkout()
        } label: {
            buttonLabel
        }
        .disabled(isImported || isImporting)
    }

    @ViewBuilder
    private var buttonLabel: some View {
        if isImported {
            Image(systemName: "checkmark.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(width: 30)
            .foregroundStyle(.green)
        }
        else {
            Text("Import")
                .foregroundStyle(.accentPrimary)
                .font(.subheadline)
                .scaleEffect(isImporting ? 0.9 : 1)
                .animation(
                    isImporting ?
                        Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) :
                        nil,
                    value: isImporting
                )
        }
    }
    
    private func saveWorkout() {
        isImporting = true
        let stairMasterWorkout = workout.toStairMasterWorkout()
        modelContext.insert(stairMasterWorkout)
        withAnimation {
            isImporting = false
            isImported = true
        }
    }
}

#Preview("Light Mode") {
    let workoutFromToday = ThirdPartyWorkout(startDate: .now, duration: 1800)
    let workoutFromYesterday = ThirdPartyWorkout(startDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, duration: 1800)
    let workoutFromThreeDaysAgo = ThirdPartyWorkout(startDate: Calendar.current.date(byAdding: .day, value: -3, to: .now)!, duration: 1800)
    let workoutFromOneMonthAgo = ThirdPartyWorkout(startDate: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, duration: 3600)
    VStack {
        // Today
        ImportWorkoutsCellView(workout: workoutFromToday)
        
        // Yesterday
        ImportWorkoutsCellView(workout: workoutFromYesterday)
        
        // Three days ago
        ImportWorkoutsCellView(workout: workoutFromThreeDaysAgo)
        
        // Last month
        ImportWorkoutsCellView(workout: workoutFromOneMonthAgo)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let workoutFromToday = ThirdPartyWorkout(startDate: .now, duration: 1800)
    let workoutFromYesterday = ThirdPartyWorkout(startDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, duration: 1800)
    let workoutFromThreeDaysAgo = ThirdPartyWorkout(startDate: Calendar.current.date(byAdding: .day, value: -3, to: .now)!, duration: 1800)
    let workoutFromOneMonthAgo = ThirdPartyWorkout(startDate: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, duration: 3600)
    VStack {
        // Today
        ImportWorkoutsCellView(workout: workoutFromToday)
        
        // Yesterday
        ImportWorkoutsCellView(workout: workoutFromYesterday)
        
        // Three days ago
        ImportWorkoutsCellView(workout: workoutFromThreeDaysAgo)
        
        // Last month
        ImportWorkoutsCellView(workout: workoutFromOneMonthAgo)
    }
    .preferredColorScheme(.dark)
}
