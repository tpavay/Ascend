//
//  MetricOverDateRangeView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

import SwiftUI

struct MetricOverDateRangeView: View {
    
    /// The metric total to display
    ///
    /// Example: 1000 steps.
    var metricTotal: Int
    
    /// The type of metric we are displaying
    var metric: StairmasterMetric
    
    /// The date range for which the metric value being displayed falls in
    var dateRange: DateRange
    
    var body: some View {
        VStack(alignment: .leading) {
            metricTotalText
            metricOverdateRangeText
        }
        .padding(.horizontal)
    }
    
    private var metricTotalText: some View {
        Text("\(metricTotal)")
            .font(.system(size: 48)).fontWeight(.heavy)
            .foregroundStyle(getMetricTextColor(displayedMetric: metric))
    }
    
    private var metricOverdateRangeText: some View {
        HStack() {
            Text(metric.description.capitalized + " " + dateRange.longDescription.lowercased())
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(Color(UIColor.secondaryLabel))
    }
    
    private func getMetricTextColor(displayedMetric: StairmasterMetric) -> Color {
        switch displayedMetric {
        case .stepsClimbed: return .accentPrimary
        case .floorsClimbed: return .accentSecondary
        case .caloriesBurned: return .accentTertiary
        case .durationClimbed: return .customBlue
        }
    }
    
}

#Preview("Light Mode") {
    NavigationStack {
        MetricOverDateRangeView(metricTotal: 0, metric: .stepsClimbed, dateRange: .weekly)
        MetricOverDateRangeView(metricTotal: 0, metric: .floorsClimbed, dateRange: .monthly)
        MetricOverDateRangeView(metricTotal: 0, metric: .caloriesBurned, dateRange: .yearly)
        MetricOverDateRangeView(metricTotal: 0, metric: .durationClimbed, dateRange: .allTime)
    }
    .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    NavigationStack {
        MetricOverDateRangeView(metricTotal: 0, metric: .stepsClimbed, dateRange: .weekly)
        MetricOverDateRangeView(metricTotal: 0, metric: .floorsClimbed, dateRange: .monthly)
        MetricOverDateRangeView(metricTotal: 0, metric: .caloriesBurned, dateRange: .yearly)
        MetricOverDateRangeView(metricTotal: 0, metric: .durationClimbed, dateRange: .allTime)
    }
    .preferredColorScheme(.dark)
}
