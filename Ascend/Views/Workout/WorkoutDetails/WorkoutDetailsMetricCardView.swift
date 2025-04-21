//
//  WorkoutDetailsMetricCardView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/21/25.
//

import SwiftUI

struct WorkoutDetailsMetricCardView: View {
    /// Represents the value of the metric being displayed
    let metricValue: String?

    /// Stair master metric being displayed
    let metric: StairmasterMetric

    /// Initializes a WorkoutDetailsMetricCardView with a metric value
    /// and an metricText
    /// If not metric value is provided we default to "--" to represent that no metric value was provided for this metric
    init(metricValue: String? = "--", metric: StairmasterMetric) {
        self.metricValue = metricValue
        self.metric = metric
    }

    var body: some View {
        VStack {
            Text(metricValue ?? "--")
                .font(.title.weight(.bold))
            Text(metric.description.capitalized)
                .font(.headline)
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.accentPrimary.opacity(0.2))
                .stroke(.accentPrimary, lineWidth: 1)
        )
    }

    
}

#Preview("Light Mode") {
    VStack {
        HStack {
            WorkoutDetailsMetricCardView(metricValue: "1:30:00", metric: .durationClimbed)
            WorkoutDetailsMetricCardView(metricValue: "1500", metric: .caloriesBurned)
        }
        HStack {
            WorkoutDetailsMetricCardView(metricValue: "8000", metric: .stepsClimbed)
            WorkoutDetailsMetricCardView(metricValue: "400", metric: .floorsClimbed)
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack {
        HStack {
            WorkoutDetailsMetricCardView(metricValue: "1:30:00", metric: .durationClimbed)
            WorkoutDetailsMetricCardView(metricValue: "1500", metric: .caloriesBurned)
        }
        HStack {
            WorkoutDetailsMetricCardView(metricValue: "8000", metric: .stepsClimbed)
            WorkoutDetailsMetricCardView(metricValue: "400", metric: .floorsClimbed)
        }
    }
    .preferredColorScheme(.dark)
    
}
