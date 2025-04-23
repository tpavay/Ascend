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
    /// Date of the workout that will come from a parent view. This view will not change it so no need to create a binding
    let workoutDate: Date

    /// Computed property that converts the workout date into a date string to be displayed within the cell. This is created here but shouldn't change so doesn't need to be an @State property
    var dateDisplayText: String {
        return Date.getTimeFrameString(from: workoutDate)
    }
    
    var workoutStartTimeDisplayText: String {
        return Date.getTwelveHourFormat(from: workoutDate)
    }

    /// Whether or not this workout has already been imported. This will need to change if the user imports the workout and the source of truth is here so this is a state property.
    @State var isImported: Bool

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
            withAnimation(.easeInOut) {
                isImported = true
            }
        } label: {
            buttonLabel
        }
        .disabled(isImported)

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
        }
    }
}

#Preview("Light Mode") {
    VStack {
        // Today
        ImportWorkoutsCellView(workoutDate: .now, isImported: false)
        
        // Yesterday
        ImportWorkoutsCellView(workoutDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, isImported: true)
        
        // Three days ago
        ImportWorkoutsCellView(workoutDate: Calendar.current.date(byAdding: .day, value: -3, to: .now)!, isImported: true)
        
        // Last month
        ImportWorkoutsCellView(workoutDate: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, isImported: true)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack {
        // Today
        ImportWorkoutsCellView(workoutDate: .now, isImported: false)
        
        // Yesterday
        ImportWorkoutsCellView(workoutDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)!, isImported: true)
        
        // Three days ago
        ImportWorkoutsCellView(workoutDate: Calendar.current.date(byAdding: .day, value: -3, to: .now)!, isImported: true)
        
        // Last month
        ImportWorkoutsCellView(workoutDate: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, isImported: true)
    }
    .preferredColorScheme(.dark)
}
