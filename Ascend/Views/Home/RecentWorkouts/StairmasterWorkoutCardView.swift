//
//  WorkoutCardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftUI

struct StairmasterWorkoutCardView: View {
    private var startTime: String
    private var dateText: String
    private var duration: String
    private var steps: Int
    private var floorsClimbed: Int
    
    init(startTime: String, dateText: String, duration: String, steps: Int, floorsClimbed: Int) {
        self.startTime = startTime
        self.dateText = dateText
        self.duration = duration
        self.steps = steps
        self.floorsClimbed = floorsClimbed
    }

    var body: some View {
        NavigationLink(destination: WorkoutDetailView()) {
            HStack() {
                Image(systemName: "clock")
                    .font(.system(size: 24))
                VStack(alignment: .leading) {
                    Text(startTime)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)
                    HStack {
                        Text("\(dateText) • \(duration) min")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                HStack {
                    Image(systemName: "figure.stairs")
                    Text("\(steps)")
                }
                .font(.footnote)
                .foregroundStyle(.gray)
                Spacer()
                HStack {
                    Image(systemName: "building")
                    Text("\(floorsClimbed)")
                }
                .foregroundStyle(.gray)
                .font(.footnote)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding()
            .border(.clear)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .shadow(color: .accentPrimary.opacity(0.2), radius: 3)
            }
            .padding(.horizontal)
        }
        
    }
}

#Preview {
    StairmasterWorkoutCardView(startTime: Date.now.formatted(.dateTime.hour().minute()), dateText: "Today", duration: "25", steps: 1500, floorsClimbed: 80)
}
