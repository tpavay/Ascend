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
    @Query private var workouts: [StairMasterWorkout]
    
    private var currentUser: AscendUser? {
        return users.first!
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack() {
                    HomeChartView()
                    if workouts.isEmpty {
                        ContentUnavailableView {
                            Circle()
                                .frame(height: 55)
                                .foregroundStyle(.accentPrimary.opacity(0.2))
                                .overlay {
                                    Image(systemName: "bolt")
                                        .font(.title2)
                                        .foregroundStyle(.accentPrimary)
                                }.padding(.bottom)
                        }
                        description: {
                            VStack(spacing: 12) {
                                Text("Ready to Ascend?")
                                    .font(.title3)
                                    .foregroundStyle(.black)
                                    .fontWeight(.bold)
                                Text("Log your first Stairmaster workout to see your progress")
                            }
                        }
                        NavigationLink(destination: LogStairmasterWorkoutMainView()) {
                            HStack {
                                Text("Log Workout")
                                Image(systemName: "chevron.right")
                            }
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(.accentPrimary)
                            .cornerRadius(50)
                            .foregroundStyle(.white)
                            
                        }
                    }
                    else {
                        Section(header: Text("Recent Workouts").font(.title3)) {
                            
    //                        StairmasterWorkoutCardView(startTime: Date.now.formatted(.dateTime.hour().minute()), dateText: "Today", duration: "25", steps: 1500, floorsClimbed: 80)
    //                        StairmasterWorkoutCardView(startTime: Date.now.formatted(.dateTime.hour().minute()), dateText: "Yesterday", duration: "15", steps: 1000, floorsClimbed: 50)
    //                        StairmasterWorkoutCardView(startTime: Date.now.formatted(.dateTime.hour().minute()), dateText: "Feb 19", duration: "10", steps: 1000, floorsClimbed: 50)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
            }.safeAreaInset(edge: .top) {
                HomeHeaderView(currentUser: currentUser!)
            }
        }
    }
}

#Preview {
    let preview = PreviewContainer([AscendUser.self, StairMasterWorkout.self])
    preview.container.mainContext.insert(AscendUser())
    return HomeMainView().modelContainer(preview.container)
}
