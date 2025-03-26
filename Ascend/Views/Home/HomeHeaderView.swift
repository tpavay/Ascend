//
//  HomeHeaderView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftData
import SwiftUI

struct HomeHeaderView: View {
    @State private var isImportWorkoutSheetPresented: Bool = false
    @State private var currentUser: AscendUser
    @State private var greetingText: String = ""
    
    init(currentUser: AscendUser) {
        self.currentUser = currentUser
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                ProfilePictureView(url: currentUser.profilePictureURL ?? "")
                
                Text(greetingText)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
//                VStack(alignment: .leading) {
//                    Text(greetingText)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.gray)
//                    Text("1000")
//                        .font(.largeTitle)
//                        .fontWeight(.semibold)
//                    Text("Steps this month")
//                        .font(.footnote)
//                }
            }
            Spacer()
            HStack(spacing: 16) {
                NavigationLink(destination: LogStairmasterWorkoutMainView()) {
                    Image(systemName: "plus.square")
                }
                Image(systemName: "bell")
                    .onTapGesture {
                        isImportWorkoutSheetPresented = true
                    }
            }
            .font(.title2)
        }
        .padding(.horizontal)
        .background(.white)
        .sheet(isPresented: $isImportWorkoutSheetPresented) {
            Text("Import Workouts View")
        }
        .onAppear {
            let timeOfDayText = "Good \(Date.getTimeOfDay().rawValue)"
            greetingText = currentUser.firstName != nil && currentUser.firstName != "" ? "\(timeOfDayText) \(currentUser.firstName!)" : timeOfDayText
        }
    }
}

#Preview {
    HomeHeaderView(currentUser: AscendUser())
}
