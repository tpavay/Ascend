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
                        LabeledTextEditorView(notes: $notes, field: .notes, focusedField: $focusedField)

//                        Section(header: dateSectionHeader) {
//                            HStack {
//                                // Workout Date
//                                DatePicker(
//                                    "",
//                                    selection: $date,
//                                    displayedComponents: [.date, .hourAndMinute]
//                                )
//                                .labelsHidden() // Get rid of the default space for the text
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                                .focused($focusedField, equals: .date)
//                            }
//                            
//                        }
                        // Duration and steps
                        HStack {
                            LabeledTextField(label: "Duration", placeholder: "00:00", text: $duration, field: .duration, focusedField: $focusedField)
                                .keyboardType(.numberPad)
                            LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalSteps, field: .totalSteps, focusedField: $focusedField)
                                .keyboardType(.numberPad)
                        }
                        
                        if isShowingHeartRateFields {
                            HStack {
                                LabeledTextField(label: "Avg Heart Rate", placeholder: "125", text: $avgHeartRate, field: .avgHeartRate, focusedField: $focusedField)
                                    .keyboardType(.numberPad)
                                LabeledTextField(label: "Max Heart Rate", placeholder: "160", text: $maxHeartRate, field: .maxHeartRate, focusedField: $focusedField)
                                    .keyboardType(.numberPad)
                            }
                        }
                        
                        if isShowingIntensityField {
                            Slider(value: $intensityLevel) {
                                Text("asdf")
                            } minimumValueLabel: {
                                Text("1")
                            } maximumValueLabel: {
                                Text("5")
                            }

                        }
                        
                        HStack {
                            Button {
                                isShowingHeartRateFields.toggle()
                            }
                            label: {
                                Text("Add Heart Rate")
                                    .padding()
                                    .frame(height: 35)
                                    .foregroundStyle(.black)
                                    .background(
                                        RoundedRectangle(cornerRadius: 35)
                                            .stroke(.black, lineWidth: 2)
                                    )
                                    
                            }
                            Button {
                                isShowingIntensityField.toggle()
                            }
                            label: {
                                Text("Add Intensity")
                                    .padding()
                                    .frame(height: 35)
                                    .foregroundStyle(.black)
                                    .background(
                                        RoundedRectangle(cornerRadius: 35)
                                            .stroke(.black, lineWidth: 2)
                                    )
                            }
                        }
                        
                        
                        
//
//                            
                        
//                        
                    }
                    .padding(.horizontal, 4) // Add padding so border sides are fully visible
                   
                }
                .padding(.horizontal, -20) // Make scroll view take up entire form width
                
                Button {
                    print("Submit")
                }
                label: {
                    Text("Submit")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.accentPrimary)
                        .cornerRadius(10)
                        .foregroundStyle(.white)
                        .padding(.vertical)
                        
                        
                }
            }.onTapGesture { // Unfocus any field when form is tapped
                focusedField = nil
            }
            .navigationTitle("Log Workout")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden) // Hide the form background
        }
    }
    
    var dateSectionHeader: some View {
        Label("Date & Time", systemImage: "clock")
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LogStairmasterWorkoutMainView()
}
