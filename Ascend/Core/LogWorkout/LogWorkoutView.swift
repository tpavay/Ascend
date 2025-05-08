//  LogWorkoutView.swift
//  Created by Tyler Pavay on 2/10/25.

import SwiftData
import SwiftUI

struct LogWorkoutView: View {
    // MARK: Environment Variables
    @Environment(\.modelContext) var modelContext
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    // MARK: State Properties
    /// ViewModel that manages that state and business logic for this view
    @State var viewModel = LogWorkoutViewModel()

    @State private var duration: String = ""
    @State private var totalSteps: String = ""
    @State private var floorsClimbed: String = ""
    @State private var caloriesBurned: String = ""
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
                VStack(spacing: 20) {
                    generalInfoSection
                    workoutStatsSection
                    submitButton
                        .padding(.top, 12)
                }
            }
            .padding(.horizontal, -20)
            .scrollContentBackground(.hidden)
            .background(colorScheme == .light ? .clear: .darkModeFormBackground)
            .navigationTitle("Log Workout")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.accentPrimary)
                    }
                }
                
                ToolbarItem(placement: .keyboard) {
                    KeyboardDismissButton()
                }
            }
        }
    }
    
    private var generalInfoSectionHeader: some View {
        Text("General Info")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3.weight(.bold))
            .foregroundStyle(Color(UIColor.label))
    }
    
    private var generalInfoSection: some View {
        Section(header: generalInfoSectionHeader) {
            workoutNameField
            workoutDateField
            workoutNotesField
        }
    }
    
    private var workoutNameField: some View {
        LabeledTextField(label: "", placeholder: "Workout Name (Optional)", text: $viewModel.workoutName, field: .workoutName, focusedField: $focusedField)
    }
    
    private var workoutDateField: some View {
        CustomDatePickerField(date: $viewModel.date)
    }
    
    private var workoutNotesField: some View {
        LabeledTextEditorView(notes: $notes, field: .notes, focusedField: $focusedField)
    }
    
    private var workoutStatsSectionHeader: some View {
        Text("Workout Stats")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3.weight(.bold))
            .foregroundStyle(Color(UIColor.label))
    }
    
    private var workoutStatsSection: some View {
        Section(header: workoutStatsSectionHeader) {
            HStack {
                durationField
                caloriesField
            }
            HStack {
                totalStepsField
                floorsClimbedField
            }
        }
    }
    
    private var durationField: some View {
        DurationField(userEnteredDuration: $duration, focusedField: $focusedField, field: .duration)
    }
    
    private var caloriesField: some View {
        LabeledTextField(label: "Calories", placeholder: "0", text: $caloriesBurned, isOptional: true, field: .caloriesBurned, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }
    
    private var totalStepsField: some View {
        LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalSteps, isOptional: true, field: .totalSteps, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }
    
    private var floorsClimbedField: some View {
        LabeledTextField(label: "Floors Climbed", placeholder: "0", text: $floorsClimbed, isOptional: true, field: .floorsClimbed, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }
    
    private var submitButton: some View {
        CustomTextButton(
            buttonText: "Submit",
            buttonTextColor: .white,
            fillColor: .accentPrimary,
            action: { submit() }
        )
        .disabled(duration.isEmpty)
        .buttonStyle(.plain)
    }
    
    

    private func submit() {
        let convertedDuration = duration.toTimeInterval()
        
       
        let stairMasterWorkout = StairMasterWorkout(workoutName: viewModel.workoutName, date: viewModel.date, duration: convertedDuration, floorsClimbed: Int(floorsClimbed), totalSteps: Int(totalSteps), caloriesBurned: Double(caloriesBurned), workoutSource: .manualEntry, notes: notes)
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
    LogWorkoutView()
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    LogWorkoutView()
    .preferredColorScheme(.dark)
}
