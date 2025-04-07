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
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
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
                CustomTextButton(buttonText: "Submit", buttonTextColor: .white, fillColor: .accentPrimary, action: { submit() })
                
            }.padding(.horizontal, -20)
            .scrollContentBackground(.hidden)
            .background(colorScheme == .light ? .clear: .darkModeFormBackground)
//            .onTapGesture { // Unfocus any field when form is tapped
//                focusedField = nil
//            } // This causes the submit button to not be able to be tapped
            .navigationTitle("Log Workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Image(systemName: "keyboard.chevron.compact.down")
                            .foregroundStyle(.accentPrimary)
                            .padding(.trailing)
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }
                }
            }
        }
    }
    
    private func submit() {
        if duration.isEmpty == nil {
            
        }
        let convertedDuration = duration.toTimeInterval()
        
       
        let stairMasterWorkout = StairMasterWorkout(workoutName: workoutName, date: date, duration: convertedDuration, totalSteps: Int(totalSteps) ?? 0, notes: notes)
        modelContext.insert(stairMasterWorkout)
        
        // Save changes (optional but recommended)
        do {
            try modelContext.save()
            // Set navigation flag to true after successful save
            dismiss()
        } catch {
            print("Error saving workout: \(error.localizedDescription)")
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
