//
//  ChartMetricTotalView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

import SwiftUI

struct ChartMetricTotalView: View {
    private var metricTotal: Int
    private var metric: StairmasterMetric
    private var dateRange: DateRange
    
    init(metricTotal: Int, metric: StairmasterMetric, dateRange: DateRange) {
        self.metricTotal = metricTotal
        self.metric = metric
        self.dateRange = dateRange
    }
    
    var body: some View {
        VStack {
            Text("\(metricTotal)")
                .font(.system(size: 56, weight: .heavy))
                .foregroundStyle(.accentPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(metric.description) \(dateRange.description)")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal)
    }
}

#Preview {
    ChartMetricTotalView(metricTotal: 0, metric: .stepsClimbed, dateRange: .monthly)
}
