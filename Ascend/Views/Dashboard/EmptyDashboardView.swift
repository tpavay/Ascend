//
//  EmptyDashboardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/14/25.
//

import SwiftUI

struct EmptyDashboardView: View {
    // Commenting out because not using current user rn
    //let currentUser: AscendUser
    @State private var isLogWorkoutFormPresented: Bool = false
    
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
                
                CustomTextButton(
                    buttonText: "Log Workout",
                    buttonTextColor: .white,
                    fillColor: .accentPrimary,
                    action: {isLogWorkoutFormPresented = true}
                )
            }
        }
    .safeAreaInset(edge: .top) {
//        DashboardHeaderView(currentUser: currentUser)
        DashboardHeaderView()
    }
    .fullScreenCover(isPresented: $isLogWorkoutFormPresented) {
        LogWorkoutView()
    }
    }
}
