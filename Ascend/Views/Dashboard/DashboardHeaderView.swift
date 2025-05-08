//
//  DashboardHeaderView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftData
import SwiftUI

struct DashboardHeaderView: View {
    @State private var isImportWorkoutSheetPresented: Bool = false
    @State private var isLogWorkoutFormPresented: Bool = false


    // commenting out because we aren't working with user yet
    //@State private var currentUser: AscendUser
    @State private var greetingText: String = ""
    
//    init(currentUser: AscendUser) {
//        self.currentUser = currentUser
//    }
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                // Just make profile picture default for now
                ProfilePictureView(url: nil)
//                ProfilePictureView(url: currentUser.profilePictureURL ?? "")
                
                Text(greetingText)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            Spacer()
            HStack(spacing: 16) {
                Image(systemName: "plus.square")
                    .onTapGesture {
                        isLogWorkoutFormPresented = true
                    }
                Image(systemName: "bell")
                    .onTapGesture {
                        isImportWorkoutSheetPresented = true
                    }
            }
            .font(.title2)
        }
        .padding(.horizontal)
        .background(Color(UIColor.systemBackground))
        .popover(isPresented: $isImportWorkoutSheetPresented, content: {
            ImportWorkoutsView()
        })
        .fullScreenCover(isPresented: $isLogWorkoutFormPresented, content: {
            LogWorkoutView()
        })
        .onAppear {
//            let timeOfDayText = "Good \(Date.getTimeOfDay().rawValue)"
//            greetingText = currentUser.firstName != nil && currentUser.firstName != "" ? "\(timeOfDayText) \(currentUser.firstName!)" : timeOfDayText

        }
    }
}

#Preview("Light Mode") {
    NavigationStack {
        DashboardHeaderView()
            .preferredColorScheme(.light)
    }
}

#Preview("Dark Mode") {
    DashboardHeaderView()
        .preferredColorScheme(.dark)
}
