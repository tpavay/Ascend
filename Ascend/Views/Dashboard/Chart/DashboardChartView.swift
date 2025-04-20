//
//  HomeChartView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/19/25.
//

import Charts
import SwiftUI

struct DashboardChartView: View {
    let allWorkouts: [StairMasterWorkout]
    
    @State private var stepDataPoints: [ChartDataPoint] = []
    @State private var floorsDataPoints: [ChartDataPoint] = []
    @State private var caloriesDataPoints: [ChartDataPoint] = []
    @State private var durationDataPoints: [ChartDataPoint] = []
    @State private var selectedMetric: StairmasterMetric = .stepsClimbed
    @State private var selectedDateRange: DateRange = .weekly
    @State var dataPoints: [ChartDataPoint] = []
    @State var chartTotal: Int = 0
    
    var body: some View {
        VStack {
            MetricOverDateRangeView(metricTotal: chartTotal, metric: selectedMetric, dateRange: selectedDateRange)
            ChartMetricPickerView(selectedChartType: $selectedMetric)
            DateRangePickerView(selectedDateRange: $selectedDateRange, selectedChartType: $selectedMetric)
            ChartView(dataPoints: dataPoints, metric: selectedMetric, chartColor: selectedMetric.color)
        }
        .onAppear {
            convertWorkoutDataToChartData()
            updateDisplayedData()
        }
        .onChange(of: selectedMetric) { _, _ in
            updateDisplayedData()
        }
        .onChange(of: selectedDateRange) { _, _ in
            updateDisplayedData()
        }
    }
    
    private func updateDisplayedData() {
        dataPoints = getDataPointsWithinDateRange(dataPoints: getSelectedDataPoints(), dateRange: selectedDateRange)
        chartTotal = Int(calculateChartTotal(dataPoints: dataPoints, selectedMetric: selectedMetric, selectedDateRange: selectedDateRange))
    }
}

extension DashboardChartView {
    func calculateChartTotal(dataPoints: [ChartDataPoint], selectedMetric: StairmasterMetric, selectedDateRange: DateRange) -> Double {
            let dataWithinDateRange = getDataPointsWithinDateRange(dataPoints: dataPoints, dateRange: selectedDateRange)
            return dataWithinDateRange.reduce(0) { sum, dataPoint in
                return sum + dataPoint.value
            }
        }
        
        func getDataPointsWithinDateRange(dataPoints: [ChartDataPoint], dateRange: DateRange) -> [ChartDataPoint] {
            guard !dataPoints.isEmpty else { return [] }
            
            switch dateRange {
            case .weekly:
                guard let oneWeekAgo = Calendar.current.date(byAdding: .weekOfYear, value: -1, to: .now) else {
                    print("error getting date")
                    return []
                }
                return dataPoints.filter { point in
                    point.date >= oneWeekAgo && point.date <= .now
                }
            case .monthly:
                guard let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: .now) else {
                    print("error getting date")
                    return []
                }
                return dataPoints.filter { point in
                    point.date >= oneMonthAgo && point.date <= .now
                }
            case .yearly:
                guard let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: .now) else {
                    print("error getting date")
                    return []
                }
                return dataPoints.filter { point in
                    point.date >= oneYearAgo && point.date <= .now
                }
            case .allTime:
                return dataPoints
            }
        }
        
        func getSelectedDataPoints() -> [ChartDataPoint] {
            switch selectedMetric {
            case .stepsClimbed: return stepDataPoints
            case .floorsClimbed: return floorsDataPoints
            case .caloriesBurned: return caloriesDataPoints
            case .durationClimbed: return durationDataPoints
            }
        }
        
        func convertWorkoutDataToChartData() {
            // Reset all chart data arrays before populating
            stepDataPoints = []
            floorsDataPoints = []
            caloriesDataPoints = []
            durationDataPoints = []
            
            for workout in allWorkouts {
                if let totalSteps = workout.totalSteps {
                    stepDataPoints.append(ChartDataPoint(date: workout.date, value: Double(totalSteps)))
                }
                
                if let floorsClimbed = workout.floorsClimbed {
                    floorsDataPoints.append(ChartDataPoint(date: workout.date, value: Double(floorsClimbed)))
                }
                
                if let calories = workout.caloriesBurned {
                    caloriesDataPoints.append(ChartDataPoint(date: workout.date, value: Double(calories)))
                }
                
                // Workouts will always have a duration
                durationDataPoints.append(ChartDataPoint(date: workout.date, value: workout.duration))
            }
            
            // Sort data points by date (oldest to newest)
            stepDataPoints.sort { $0.date < $1.date }
            floorsDataPoints.sort { $0.date < $1.date }
            caloriesDataPoints.sort { $0.date < $1.date }
            durationDataPoints.sort { $0.date < $1.date }
        }
    }


