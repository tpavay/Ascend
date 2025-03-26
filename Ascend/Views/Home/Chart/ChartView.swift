//
//  ChartView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

import Charts
import SwiftUI

struct ChartView: View {
    private var dataPoints: [StairmasterDataPoint]
    private var metric: StairmasterMetric
    @State private var rawSelectedDate: Date?
    
    init(dataPoints: [StairmasterDataPoint], metric: StairmasterMetric) {
        self.dataPoints = dataPoints
        self.metric = metric
    }
    
    var body: some View {
        Chart() {
            ForEach(dataPoints, id: \.id) { dataPoint in
                LineMark(x: .value("Date", dataPoint.date), y: .value(metric.description, dataPoint.value))
                    .foregroundStyle(.accentPrimary)
            }
        }
        .chartXSelection(value: $rawSelectedDate)
        .frame(height: 150)
        .padding()
        .chartXAxisLabel(alignment: .center) {
            Text("Date")
                .font(.subheadline)
        }
        .chartYAxisLabel(alignment: .trailing, spacing: 12) {
            Text(metric.description)
                .font(.subheadline)
        }
    }
}

#Preview {
    let stepDataPoints = ChartDataHelper.createStepsData()
    let metric: StairmasterMetric = .stepsClimbed
    
    ChartView(dataPoints: stepDataPoints, metric: metric)
}
