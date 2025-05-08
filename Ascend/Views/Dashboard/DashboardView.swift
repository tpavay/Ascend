//
//  DashboardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/17/25.
//
import SwiftData
import SwiftUI

/// Generic point structure for charts
struct ChartDataPoint {
    var id: UUID = UUID()
    var date: Date
    var value: Double
}

struct DashboardView: View {
    // Commenting for now because we aren't going to save user yet
    //@Query private var users: [AscendUser]

    /// Query for all StairMaster workouts and sort them from newest to oldest date
    @Query(sort: \StairMasterWorkout.date, order: .reverse) private var allWorkouts: [StairMasterWorkout]
    
    @State private var recentWorkouts: [StairMasterWorkout] = []

    // commenting because we aren't working with users yet
//    private var currentUser: AscendUser? {
//        return users.first!
//    }
    
    var body: some View {
        NavigationStack {
            if allWorkouts.isEmpty {
                EmptyDashboardView()
            } else {
                ScrollView {

                    DashboardChartView(allWorkouts: allWorkouts)
                    
                    
                    Section(header: Text("Recent Workouts").font(.title3.weight(.bold))) {
                        VStack(spacing: 16) {
                            ForEach(recentWorkouts) { workout in
                                StairmasterWorkoutCardView(workout: workout)
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                .safeAreaInset(edge: .top) {
                    DashboardHeaderView()
                }
                .onAppear {
                    recentWorkouts = getThreeMostRecentWorkouts()
                }
                .onChange(of: allWorkouts) { _, _ in
                    recentWorkouts = getThreeMostRecentWorkouts()
                }
            }
        }
    }
}

extension DashboardView {
    func getThreeMostRecentWorkouts() -> [StairMasterWorkout] {
        if allWorkouts.isEmpty {
            return []
        }
        
        if allWorkouts.count == 1 {
            return [allWorkouts[0]]
        }
        
        if allWorkouts.count == 2 {
            return Array(allWorkouts[0...1])
        }
        
        return Array(allWorkouts[0...2])
    }
    
}

#Preview("Light Mode") {
    let preview = PreviewContainer([AscendUser.self, StairMasterWorkout.self])
    preview.container.mainContext.insert(AscendUser())
    return DashboardView().modelContainer(preview.container)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let preview = PreviewContainer([AscendUser.self, StairMasterWorkout.self])
    preview.container.mainContext.insert(AscendUser())
    return DashboardView().modelContainer(preview.container)
        .preferredColorScheme(.dark)
}
