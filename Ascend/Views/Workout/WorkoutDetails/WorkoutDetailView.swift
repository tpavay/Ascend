//
//  WorkoutDetailView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftUI

struct WorkoutFormData {
    var workoutName: String
    var date: Date
    var duration: String
    var floorsClimbed: String?
    var totalSteps: String?
    var caloriesBurned: String?
//    var avgHeartRate: String?
//    var maxHeartRate: String?
    var workoutSource: String
    var notes: String?
    
    init(from workout: StairMasterWorkout) {
        workoutName = workout.workoutName
        date = workout.date
        duration = String.convertDurationsInSecondsToHoursMinutesSecondsString(from: Int(workout.duration))
        floorsClimbed = "\(workout.floorsClimbed ?? 0)"
        totalSteps = "\(workout.totalSteps ?? 0)"
        caloriesBurned = "\(Int(workout.caloriesBurned ?? 0))"
        notes = workout.notes
        workoutSource = workout.workoutSource.description
    }
}

struct WorkoutDetailView: View {
    @State var workoutData: WorkoutFormData
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                workoutNameText
                dateAndTimeText
                workoutMetrics
                    .padding(.vertical, 8)
                if workoutData.notes != "" {
                    notesSection
                }
                Divider()
                workoutSource
            }
            .navigationTitle("Workout Details")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var workoutNameText: some View {
        Text(workoutData.workoutName)
            .font(.largeTitle.weight(.bold))
    }
    
    private var dateAndTimeText: some View {
        HStack {
            Text(Date.getTimeFrameString(from: workoutData.date))
            Text(Date.getTwelveHourFormat(from: workoutData.date))
        }
        .font(.headline)
        .foregroundStyle(Color(UIColor.secondaryLabel))
    }
    
    private var workoutMetrics: some View {
        VStack {
            HStack {
                WorkoutDetailsMetricCardView(metricValue: workoutData.duration, metric: .durationClimbed)
                WorkoutDetailsMetricCardView(metricValue: workoutData.caloriesBurned, metric: .caloriesBurned)
            }
            HStack {
                WorkoutDetailsMetricCardView(metricValue: workoutData.floorsClimbed, metric: .floorsClimbed)
                WorkoutDetailsMetricCardView(metricValue: workoutData.totalSteps, metric: .stepsClimbed)
            }
        }
    }
    
    @ViewBuilder
    private var notesSection: some View {
        if let notes = workoutData.notes {
            Divider()
            Section(header: notesSectionHeader) {
                Text(notes)
                    .font(.headline.weight(.medium))
                    .foregroundStyle(.primary.opacity(0.6))
            }
        }
        else {
            EmptyView()
        }
    }
    
    private var notesSectionHeader: some View {
        Text("Notes")
            .font(.title3.weight(.bold))
            
    }
    
    private var workoutSource: some View {
        HStack {
            Text("Workout Source")
                .bold()
            Spacer()
            Text(workoutData.workoutSource)
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
        
    }
}

#Preview("Light Mode") {
    @Previewable @State var sampleWorkoutData: WorkoutFormData = WorkoutFormData(from: StairMasterWorkout(workoutName: "My workout", duration: 1000, workoutSource: .manualEntry, notes: "This was such an amazing workout! Wow I really really really enjoyed that."))
    
    WorkoutDetailView(workoutData: sampleWorkoutData)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    @Previewable @State var sampleWorkoutData: WorkoutFormData = WorkoutFormData(from: StairMasterWorkout(workoutName: "My workout", duration: 1800, workoutSource: .manualEntry))
    
    WorkoutDetailView(workoutData: sampleWorkoutData)
        .preferredColorScheme(.dark)
}
