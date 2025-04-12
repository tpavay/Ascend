//
//  HomeMainView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/17/25.
//
import SwiftData
import SwiftUI

struct HomeMainView: View {
    @Query private var users: [AscendUser]
    
    /// Query for all StairMaster workouts and sort them from newest to oldest date
    @Query(sort: \StairMasterWorkout.date, order: .reverse) private var allWorkouts: [StairMasterWorkout]
    
    @State private var recentWorkouts: [StairMasterWorkout] = []
    
    private var currentUser: AscendUser? {
        return users.first!
    }
    
    var body: some View {
        NavigationStack {
            if allWorkouts.isEmpty {
                    ContentUnavailableView {
                        Circle()
                            .frame(height: 55)
                            .foregroundStyle(.accentPrimary.opacity(0.2))
                            .overlay {
                                Image(systemName: "bolt")
                                    .font(.title2)
                                    .foregroundStyle(.accentPrimary)
                            }
                    }
                    description: {
                        VStack(spacing: 8) {
                            Text("Ready to Ascend?")
                                .font(.title)
                                .foregroundStyle(.primary)
                                .fontWeight(.bold)
                            
                            Text("Log your first Stairmaster workout to see your progress")
                                .padding(.bottom, 12)
                            
                            NavigationLink(destination: LogStairmasterWorkoutMainView()) {
                                HStack {
                                    Text("Log Workout")
                                    Image(systemName: "chevron.right")
                                }
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.accentPrimary)
                                )
                                
                            }
                        }
                    }
                .safeAreaInset(edge: .top) {
                    HomeHeaderView(currentUser: currentUser!)
                }
            } else {
                ScrollView {
                    HomeChartView()
                    Section(header: Text("Recent Workouts").font(.title3.weight(.bold))) {
                        ForEach(recentWorkouts) { workout in
                            StairmasterWorkoutCardView(workout: workout)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                }
                .safeAreaInset(edge: .top) {
                    HomeHeaderView(currentUser: currentUser!)
                }
                .onAppear {
                    recentWorkouts = getThreeMostRecentWorkouts(workouts: allWorkouts)
                }
            }
        }
    }
}

extension HomeMainView {
    func getThreeMostRecentWorkouts(workouts: [StairMasterWorkout]) -> [StairMasterWorkout] {
        if workouts.isEmpty {
            return []
        }
        
        if workouts.count == 1 {
            return [workouts[0]]
        }
        
        if workouts.count == 2 {
            return Array(workouts[0...1])
        }
        
        return Array(workouts[0...2])
    }
}

#Preview("Light Mode") {
    let preview = PreviewContainer([AscendUser.self, StairMasterWorkout.self])
    preview.container.mainContext.insert(AscendUser())
    return HomeMainView().modelContainer(preview.container)
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    let preview = PreviewContainer([AscendUser.self, StairMasterWorkout.self])
    preview.container.mainContext.insert(AscendUser())
    return HomeMainView().modelContainer(preview.container)
        .preferredColorScheme(.dark)
}
