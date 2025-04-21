//
//  WorkoutHistoryView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftData
import SwiftUI

struct WorkoutHistoryView: View {
    /// Query for all StairMaster workouts and sort them from newest to oldest date
    @Query(sort: \StairMasterWorkout.date, order: .reverse) private var allWorkouts: [StairMasterWorkout]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(allWorkouts, id: \.self) { workout in
                        StairmasterWorkoutCardView(workout: workout)
                    }
                }
                .navigationTitle("Workout History")
                .navigationBarTitleDisplayMode(.inline)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
            }
        }
    }
}
