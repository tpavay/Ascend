//
//  WorkoutDetailsGeneralInfoCard.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/19/25.
//

import SwiftUI

struct WorkoutDetailsGeneralInfoCard: View {
    let workoutName: String
    let date: Date
    let duration: String
    var displayDate: String {
        return
            date.formatted(.dateTime.weekday(.wide)) + ", " +
            date.formatted(.dateTime.month(.wide).day()) + ", " +
            date.formatted(.dateTime.year())
    }
    var workoutTime: String { date.formatted(.dateTime.hour().minute()) }
    
    var body: some View {
        HStack {
            rectangle
            leftColumnContent
            durationCube
        }
        .frame(height: 100)
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color(UIColor.label).opacity(0.3), radius: 10)
        )
        .padding()
    }
    
    private var rectangle: some View {
        Rectangle()
            .frame(width: 4)
    }
    
    private var workoutText: some View {
        Text(workoutName)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3.weight(.bold))
    }
    
    private var dateTimeText: some View {
        VStack(alignment: .leading) {
            Text(displayDate)
            Text(workoutTime)
        }
        .font(.footnote)
        .foregroundStyle(Color(UIColor.secondaryLabel))
    }
    
    private var leftColumnContent: some View {
        VStack(alignment: .leading) {
            workoutText
            dateTimeText
        }
        .padding(.leading)
    }
    
    private var durationValueText: some View {
        Text(duration)
            .font(.title.weight(.bold))
            .foregroundStyle(.white)
    }
    
    private var durationText: some View {
        Text("minutes")
            .foregroundStyle(.white)
            .fontWeight(.bold)
    }
    
    private var durationCube: some View {
        VStack {
            durationValueText
            durationText
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.accentPrimary)
        )
    }
}

#Preview("Light Mode") {
    VStack {
        WorkoutDetailsGeneralInfoCard(workoutName: "My workout", date: .now, duration: "30")
        //WorkoutDetailsGeneralInfoCard(workoutName: "", date: .now, duration: "20")
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack {
        WorkoutDetailsGeneralInfoCard(workoutName: "My workout", date: .now, duration: "20")
        WorkoutDetailsGeneralInfoCard(workoutName: "", date: .now, duration: "20")
    }
    .preferredColorScheme(.dark)
}
