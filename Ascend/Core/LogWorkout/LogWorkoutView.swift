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

    
    @FocusState private var focusedField: LogStairMasterWorkoutFormField?

    var body: some View {
        NavigationStack {
            Form {
                VStack(spacing: 20) {
                    generalInfoSection
                    workoutStatsSection
                }

            }
            .safeAreaInset(edge: .bottom, content: {
                VStack {
                    submitButton
                        .padding(.horizontal)
                }
                .padding()
                .background(.thinMaterial)

            })
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
        LabeledTextField(label: "", placeholder: "", text: $viewModel.workoutName, field: .workoutName, focusedField: $focusedField)
    }
    
    private var workoutDateField: some View {
        CustomDatePickerField(date: $viewModel.date)
    }

    private var workoutNotesField: some View {
        LogWorkoutTextEditorView(notes: $viewModel.workoutNotes, field: .notes, focusedField: $focusedField)
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
            HStack {
                avgHeartRateField
                maxHeartRateField
            }
        }
    }
    
    private var durationField: some View {
        DurationField(userEnteredDuration: $viewModel.duration, focusedField: $focusedField, field: .duration)
    }
    
    private var caloriesField: some View {
        LabeledTextField(label: "Calories", placeholder: "0", text: $viewModel.caloriesBurned, isOptional: true, field: .caloriesBurned, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }
    
    private var totalStepsField: some View {
        LabeledTextField(label: "Total Steps", placeholder: "0", text: $viewModel.totalSteps, isOptional: true, field: .totalSteps, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }
    
    private var floorsClimbedField: some View {
        LabeledTextField(label: "Floors Climbed", placeholder: "0", text: $viewModel.floorsClimbed, isOptional: true, field: .floorsClimbed, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }

    private var avgHeartRateField: some View {
        LabeledTextField(label: "Avg Heart Rate", placeholder: "0", text: $viewModel.avgHeartRate, isOptional: true, field: .avgHeartRate, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }

    private var maxHeartRateField: some View {
        LabeledTextField(label: "Max Heart Rate", placeholder: "0", text: $viewModel.maxHeartRate, isOptional: true, field: .maxHeartRate, focusedField: $focusedField)
            .keyboardType(.numberPad)
    }


    private var submitButton: some View {
        CustomTextButton(
            buttonText: "Save",
            buttonTextColor: .white,
            fillColor: .accentPrimary,
            action: { submit() }
        )
        .disabled(viewModel.duration.isEmpty)
        .buttonStyle(.plain)
    }
    
    

    private func submit() {
        let convertedDuration = viewModel.duration.toTimeInterval()
        
       
        let stairMasterWorkout = StairMasterWorkout(workoutName: viewModel.workoutName, date: viewModel.date, duration: convertedDuration, floorsClimbed: Int(viewModel.floorsClimbed), totalSteps: Int(viewModel.totalSteps), caloriesBurned: Double(viewModel.caloriesBurned), workoutSource: .manualEntry, notes: viewModel.workoutNotes)
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
