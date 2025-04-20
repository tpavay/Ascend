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
                
                // The line itself
                LineMark(x: .value("Date", point.date), y: .value(metric.description, point.value))
                    .foregroundStyle(chartColor)
                    .lineStyle(StrokeStyle(lineWidth: lineWidth))
                    .interpolationMethod(.catmullRom) // Rounded line
                
                // Area fill with gradient
                AreaMark(x: .value("Date", point.date), y: .value(metric.description, point.value))
                    .foregroundStyle(
                        .linearGradient(
                            colors: [chartColor, chartColor.opacity(0.65)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .interpolationMethod(.catmullRom) // Rounded area to match line
                
//                BarMark(x: .value("Date", point.date), yStart: .value("start", 0), yEnd: .value("Value", point.value))
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
