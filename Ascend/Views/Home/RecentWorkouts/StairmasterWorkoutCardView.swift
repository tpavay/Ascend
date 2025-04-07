//
//  WorkoutCardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import SwiftUI

struct StairmasterWorkoutCardView: View {
    private var duration: CGFloat
    private var steps: Int?
    private var floorsClimbed: Int?
    private var date: Date
    
    init(duration: CGFloat, steps: Int? = nil, floorsClimbed: Int? = nil, date: Date) {
        self.duration = duration
        self.steps = steps
        self.floorsClimbed = floorsClimbed
        self.date = date
    }

    var body: some View {
        NavigationLink(destination: WorkoutDetailView()) {
            HStack() {
                Image(systemName: "clock")
                    .font(.system(size: 24))
                    .foregroundStyle(Color(UIColor.label))
                VStack(alignment: .leading) {
                    Text(Date.getTwelveHourFormat(from: date))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color(UIColor.label)) // Makes the time white/black for light/dark mode. .primary makes it .accentColor since in NavigationLink
                    HStack {
                        Text("\(Date.getTimeFrameString(from: date)) • \(String.secondsToMinutesString(seconds: duration)) min")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                if steps != nil {
                    HStack {
                        Image(systemName: "figure.stairs")
                        Text("\(steps ?? 0)")
                    }
                    .font(.footnote)
                    .foregroundStyle(.gray)
                    Spacer()
                }
                

                
                if floorsClimbed != nil {
                    HStack {
                        Image(systemName: "building")
                        Text("\(floorsClimbed ?? 0)")
                    }
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    Spacer()
                }
                
                
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color(UIColor.label))
            }
            .padding()
            .border(.clear)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: .primary.opacity(0.2), radius: 5)
            }
            .padding(.horizontal)
        }
    }
}

#Preview("Light Mode") {
    NavigationStack {
        StairmasterWorkoutCardView(duration: 1800, steps: 1500, floorsClimbed: 80, date: Date())
            .preferredColorScheme(.light)
        
        StairmasterWorkoutCardView(duration: 1800, floorsClimbed: 80, date: Date())
            .preferredColorScheme(.dark)
        
        StairmasterWorkoutCardView(duration: 1800, steps: 1500, date: Date())
            .preferredColorScheme(.dark)
        
        StairmasterWorkoutCardView(duration: 1800, date: Date())
            .preferredColorScheme(.dark)
    }
}

#Preview("Dark Mode") {
    NavigationStack {
        StairmasterWorkoutCardView(duration: 1800, steps: 1500, floorsClimbed: 80, date: Date())
            .preferredColorScheme(.dark)
        
        StairmasterWorkoutCardView(duration: 1800, floorsClimbed: 80, date: Date())
            .preferredColorScheme(.dark)
        
        StairmasterWorkoutCardView(duration: 1800, steps: 1500, date: Date())
            .preferredColorScheme(.dark)
        
        StairmasterWorkoutCardView(duration: 1800, date: Date())
            .preferredColorScheme(.dark)
    }

}
