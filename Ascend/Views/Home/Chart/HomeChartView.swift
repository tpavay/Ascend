//
//  HomeChartView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/19/25.
//

import Charts
import SwiftUI

struct HomeChartView: View {
    @State var selectedMetric: StairmasterMetric = .stepsClimbed
    @State var stepsClimbed: Int
    @State var floorsClimbed: Int
    @State var caloriesBurned: Int
    @State var durationClimbed: Int
    @State var chartTotal: Int
    @State var textString: String
    @State var timeWindowString = "this month"
    @State var selectedChartData = []
    
    init() {
        chartTotal = ChartDataHelper.createStepsData().reduce(0) {$0 + $1.value}
        stepsClimbed = ChartDataHelper.createStepsData().reduce(0) {$0 + $1.value}
        
        floorsClimbed = ChartDataHelper.createFloorsClimbedData().reduce(0) {$0 + $1.value}
        caloriesBurned = ChartDataHelper.createCaloriesBurnedData().reduce(0) {$0 + $1.value}
        durationClimbed = ChartDataHelper.createDurationClimbedData().reduce(0) {$0 + $1.value}
        
        textString = "Stairmaster steps"
        selectedChartData = ChartDataHelper.createStepsData()
    }

    var body: some View {
        VStack {
            ChartMetricTotalView(metricTotal: chartTotal, metric: selectedMetric, dateRange: .monthly)
            Picker("", selection: $selectedMetric) {
                ForEach(StairmasterMetric.allCases, id: \.self) { metric in
                    Text(metric.description.split(separator: " ").first!)
                }
            }
            .onChange(of: selectedMetric, { oldValue, newValue in
                if selectedMetric == .stepsClimbed {
                    chartTotal = stepsClimbed
                }
                else if selectedMetric == .floorsClimbed {
                    chartTotal = floorsClimbed
                }
                else if selectedMetric == .caloriesBurned {
                    chartTotal = caloriesBurned
                }
                else if selectedMetric == .durationClimbed {
                    chartTotal = durationClimbed
                }
            })
            .padding()
            .pickerStyle(.segmented)
            if selectedMetric == .stepsClimbed {
                ChartView(dataPoints: ChartDataHelper.createStepsData(), metric: .stepsClimbed)
            }
            else if selectedMetric == .floorsClimbed {
                ChartView(dataPoints: ChartDataHelper.createFloorsClimbedData(), metric: .floorsClimbed)
            }
            else if selectedMetric == .caloriesBurned {
                ChartView(dataPoints: ChartDataHelper.createCaloriesBurnedData(), metric: .caloriesBurned)
            }
            else if selectedMetric == .durationClimbed {
                ChartView(dataPoints: ChartDataHelper.createDurationClimbedData(), metric: .durationClimbed)
            }
        }
    }
}

#Preview {
    HomeChartView()
}

