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
            /*
             VStack
                 Header
                     HStack with:
                        VStack with
                            Date or day of the week
                            start time
                        Spacer
                        Input method: Manual entry or apple fitness or strava
                
                Main Content
                    HStack that will depend on content logged in workout
                    
                        
             */
            
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
