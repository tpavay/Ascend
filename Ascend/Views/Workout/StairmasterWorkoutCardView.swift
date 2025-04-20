//
//  WorkoutCardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftUI

struct StairmasterWorkoutCardView: View {
    let workout: StairMasterWorkout
    
    var body: some View {
        NavigationLink(destination: WorkoutDetailView(workoutData: WorkoutFormData(from: workout))) {
            HStack {
                leftColumnContent
                Spacer()
                rightColumnContent
                
            }
            .frame(height: 80, alignment: .top)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: Color(UIColor.label).opacity(0.1), radius: 5)
            )
        }
    }
    
    private var leftColumnContent: some View {
        VStack(alignment: .leading) {
            workoutDate
            durationView
            HStack {
                stepsView
                floorsView
            }
        }
    }
    
    private var rightColumnContent: some View {
        VStack(alignment: .trailing) {
            workoutTime
            Spacer()
            workoutSource
        }
    }
    
    private var workoutDate: some View {
        Text(Date.getTimeFrameString(from: workout.date))
            .foregroundStyle(Color(UIColor.secondaryLabel))
            .fontWeight(.bold)
    }
    
    private var workoutTime: some View {
        Text(Date.getTwelveHourFormat(from: workout.date))
            .foregroundStyle(Color(UIColor.secondaryLabel))
    }
    
    @ViewBuilder
    private var workoutSource: some View {
        if workout.workoutSource == .strava {
            Image("StravaText")
                .resizable()
                .scaledToFit()
                .frame(width: 70)
        }
        else if workout.workoutSource == .appleFitness {
            HStack {
                Image("AppleFitnessLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                Text("Apple Fitness")
                    .foregroundStyle(Color(UIColor.label))
                    .font(.subheadline.weight(.bold))
            }
            
        }
        else {
            Text("Manual")
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
    }
    
    @ViewBuilder
    private var stepsView: some View {
        let steps = workout.totalSteps ?? 0
        if steps <= 0 {
            EmptyView()
        }
        else {
            
            HStack {
                Image(systemName: StairmasterMetric.stepsClimbed.imageText)
                Text("\(steps)")
                    .foregroundStyle(Color(UIColor.secondaryLabel))
            }
        }
    }
    
    @ViewBuilder
    private var floorsView: some View {
        let floors = workout.floorsClimbed ?? 0
        if floors <= 0 {
            EmptyView()
        }
        else {
            HStack {
                Image(systemName: StairmasterMetric.floorsClimbed.imageText)
                Text("\(floors)")
                    .foregroundStyle(Color(UIColor.secondaryLabel))
            }
        }
    }
    
    private var durationView: some View {
        Text(String.secondsToMinutesString(seconds: workout.duration) + " min")
            .font(.title2.weight(.bold))
            .foregroundStyle(Color(UIColor.label))
    }
    
    private var chevronRight: some View {
        Image(systemName: "chevron.right")
    }
}

#Preview("Light Mode") {
    let workout1: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, workoutSource: .manualEntry)
    
    let workout2: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, totalSteps: 1000, workoutSource: .appleFitness)
    
    let workout3: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, floorsClimbed: 10, workoutSource: .strava)
    
    let workout4: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, floorsClimbed: 10, totalSteps: 1000, workoutSource: .manualEntry)
    
    NavigationStack {
        StairmasterWorkoutCardView(workout: workout1)
            .padding()
        
        StairmasterWorkoutCardView(workout: workout2)
            .padding()
        
        StairmasterWorkoutCardView(workout: workout3)
            .padding()
        
        StairmasterWorkoutCardView(workout: workout4)
            .padding()
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let workout1: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, workoutSource: .manualEntry)
    
    let workout2: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, totalSteps: 1000, workoutSource: .appleFitness)
    
    let workout3: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, floorsClimbed: 10, workoutSource: .strava)
    
    let workout4: StairMasterWorkout = StairMasterWorkout(workoutName: "Morning Climb", duration: 1800, floorsClimbed: 10, totalSteps: 1000, workoutSource: .manualEntry)
    
    NavigationStack {
        StairmasterWorkoutCardView(workout: workout1)
            .padding()
        
        StairmasterWorkoutCardView(workout: workout2)
            .padding()
        
        StairmasterWorkoutCardView(workout: workout3)
            .padding()
        
        StairmasterWorkoutCardView(workout: workout4)
            .padding()
    }
    .preferredColorScheme(.dark)
}
