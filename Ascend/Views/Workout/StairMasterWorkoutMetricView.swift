//
//  StairMasterWorkoutStatView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/7/25.
//

import SwiftUI

struct StairMasterWorkoutMetricView: View {
    var metric: StairmasterMetric?
    var metricValue: CGFloat?
    
    var body: some View {
        HStack {
            Image(systemName: metric?.imageText ?? "clock")
                .font(.headline)
                .foregroundStyle(.accentPrimary)
            VStack(alignment: .leading) {
                Text("\(Int(metricValue ?? 0))")
                    .font(.body)
                    .fontWeight(.heavy)
                Text("\(metric?.description ?? "Description")")
                    .font(.footnote)
                    .foregroundStyle(Color(UIColor.secondaryLabel))
            }
        }
    }
}

#Preview("Light Mode") {
    VStack {
        HStack {
            StairMasterWorkoutMetricView(metric: .stepsClimbed, metricValue: 1500)
            StairMasterWorkoutMetricView(metric: .floorsClimbed, metricValue: 1500)
            StairMasterWorkoutMetricView(metric: .durationClimbed, metricValue: 1500)
        }
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    VStack {
        HStack {
            StairMasterWorkoutMetricView(metric: .stepsClimbed, metricValue: 1500)
            StairMasterWorkoutMetricView(metric: .floorsClimbed, metricValue: 1500)
            StairMasterWorkoutMetricView(metric: .durationClimbed, metricValue: 1500)
        }
    }
    .preferredColorScheme(.dark)
}
