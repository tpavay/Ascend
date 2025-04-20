//
//  EmptyDashboardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/14/25.
//

import SwiftUI

struct EmptyDashboardView: View {
    let currentUser: AscendUser
    
    var body: some View {
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
        DashboardHeaderView(currentUser: currentUser)
    }
    }
}
