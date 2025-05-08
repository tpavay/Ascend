//
//  ChartView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/20/25.
//

import Charts
import SwiftUI

struct ChartView: View {
    let dataPoints: [ChartDataPoint]
    let metric: StairmasterMetric
    let chartColor: Color
    let lineWidth: CGFloat = 4
     

    var body: some View {
        Chart {
            ForEach(dataPoints, id: \.id) { point in
                BarMark(x: .value("Date", point.date, unit: .day), y: .value("Value", point.value))
                    .foregroundStyle(chartColor)
                    .cornerRadius(10)
            }
        }
        .chartXAxis {
            AxisMarks(values: .stride(by: .day)) { value in
                AxisValueLabel(format: .dateTime.weekday(.abbreviated))
            }
        }
        .frame(height: 150)
        .padding()
    }
}

#Preview("Light Mode") {
    ChartView(dataPoints: ChartDataHelper.createStepsChartData(), metric: .stepsClimbed, chartColor: .accentPrimary)
        .preferredColorScheme(.light)
}
