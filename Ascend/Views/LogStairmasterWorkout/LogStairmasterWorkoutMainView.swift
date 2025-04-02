//  LogStairmasterWorkoutView.swift
//  Created by Tyler Pavay on 2/10/25.

import SwiftData
import SwiftUI

enum LogStairMasterWorkoutFormField: Hashable {
    case date
    case workoutName
    case notes
    case duration
    case totalSteps
    case avgHeartRate
    case maxHeartRate
    case intensity
}

struct LogStairmasterWorkoutMainView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var date: Date = Date()
    @State private var workoutName: String = ""
    @State private var duration: String = ""
    @State private var totalSteps: String = ""
    @State private var notes: String = ""
    @State private var avgHeartRate: String = ""
    @State private var maxHeartRate: String = ""
    @State private var isShowingHeartRateFields: Bool = false
    @State private var isShowingIntensityField: Bool = false
    @State private var intensityLevel: Double = 3
    @FocusState private var focusedField: LogStairMasterWorkoutFormField?

    var body: some View {
        NavigationStack {
            Form {
                ScrollView {
                    VStack(spacing: 20) {
                        LabeledTextField(label: "", placeholder: "Morning Climb", text: $workoutName, field: .workoutName, focusedField: $focusedField).frame(maxWidth: .infinity)
                        CustomDatePickerField(date: $date)
                        LabeledTextEditorView(notes: $notes, field: .notes, focusedField: $focusedField)

                        // Duration and steps
                        HStack {
                            DurationField(userEnteredDuration: $duration, focusedField: $focusedField, field: .duration)
                                
                            LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalSteps, field: .totalSteps, focusedField: $focusedField)
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding(.horizontal, 4) // Add padding so border sides are fully visible
                }
                CustomTextButton(buttonText: "Submit", buttonTextColor: .white, fillColor: .accentPrimary, action: { print("Submitted") })
            }.padding(.horizontal, -20)
            .scrollContentBackground(.hidden)
            .background(colorScheme == .light ? .clear: .darkModeFormBackground)
            .onTapGesture { // Unfocus any field when form is tapped
                focusedField = nil
            }
            .navigationTitle("Log Workout")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var dateSectionHeader: some View {
        Label("Date & Time", systemImage: "clock")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview("Light Mode") {
    LogStairmasterWorkoutMainView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    LogStairmasterWorkoutMainView()
    .preferredColorScheme(.dark)
}
