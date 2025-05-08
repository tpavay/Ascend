//
//  HomeChartView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/19/25.
//

import Charts
import SwiftUI

struct DashboardChartView: View {
    var allWorkouts: [StairMasterWorkout]
    
    @State private var stepDataPoints: [ChartDataPoint] = []
    @State private var floorsDataPoints: [ChartDataPoint] = []
    @State private var caloriesDataPoints: [ChartDataPoint] = []
    @State private var durationDataPoints: [ChartDataPoint] = []
    @State private var selectedMetric: StairmasterMetric = .stepsClimbed
    @State private var selectedDateRange: DateRange = .weekly
    @State var dataPoints: [ChartDataPoint] = []
    @State var chartTotal: String = ""
    
    /// Variable used to determine if the chart should be shown
    @State var shouldShowChart: Bool = true
    
    var body: some View {
        VStack {
            MetricOverDateRangeView(metricTotal: chartTotal, metric: selectedMetric, dateRange: .weekly)
            ChartMetricPickerView(selectedChartType: $selectedMetric)
            if shouldShowChart {
                //DateRangePickerView(selectedDateRange: $selectedDateRange, selectedChartType: $selectedMetric)
                ChartView(dataPoints: dataPoints, metric: selectedMetric, chartColor: selectedMetric.color)
            }
            else {
                emptyChartMessage
            }

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
        .onChange(of: allWorkouts) { _, _ in
            convertWorkoutDataToChartData()
            updateDisplayedData()
        }
    }
    
    private var emptyChartMessage: some View {
        VStack(spacing: 12) {
            Text("No \(selectedMetric.description.lowercased()) data available.")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text("Log a workout with \(selectedMetric.description.lowercased()) to view chart.")
        }
        .padding()
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: Color(UIColor.label).opacity(0.3), radius: 4)
        )
        .padding()
    }
    private func updateDisplayedData() {
        // Hard code this to be weekly for now. TODO: should change later to allow for all date ranges
        //dataPoints = getDataPointsWithinDateRange(dataPoints: getSelectedDataPoints(), dateRange: .weekly)
        processWeeklyData()
        let chartTotalNumericValue = Int(calculateChartTotal(dataPoints: dataPoints, selectedMetric: selectedMetric, selectedDateRange: .weekly))

        // If the metric we have selected is greater than 0, that means it has data in the past week and
        // we should show that chart. Otherwise we should hide the chart and show the empty chart message.
        shouldShowChart = chartTotalNumericValue > 0 ? true: false
        
        if selectedMetric == .durationClimbed {
            chartTotal = String.convertDurationsInSecondsToHoursMinutesSecondsString(from: chartTotalNumericValue)
        }
        else {
            chartTotal = "\(chartTotalNumericValue)"
        }
    }
    
    private func processWeeklyData() {
        // Clear existing data
        dataPoints = []
        
        // Get the current date and calculate the start of the week
        let today = Date()
        let startOfWeek = getStartOfWeek(for: today)
        let calendar = Calendar.current
        
        // Get localized weekday abbreviations ordered by the locale's weekday sequence
        //let weekdayLabels = getLocalizedWeekdayLabels()
        
        // Filter workouts to this week only using our helper function
        let thisWeekWorkouts = filterWorkoutsByTimeFrame(workouts: allWorkouts, timeFrame: .weekly)
        
        // Create data points for each day of the week
        for dayOffset in 0..<7 {
            let currentDay = calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)!
            
            // Get workouts for this specific day
            let dayWorkouts = thisWeekWorkouts.filter { workout in
                calendar.isDate(workout.date, inSameDayAs: currentDay)
            }
            
            // Calculate the metric value for this day using our helper function
            let value = calculateCumulativeMetricFromWorkouts(
                workouts: dayWorkouts,
                metric: selectedMetric
            )
            
            // Always add a data point for each day of the week, even if value is 0
            dataPoints.append(ChartDataPoint(
                date: currentDay,
                value: value,
            ))
        }
        
        // Sort by date to ensure proper ordering
        dataPoints.sort { $0.date < $1.date }
    }
}

extension DashboardChartView {
    /**
     * Gets the weekday labels for the current locale.
     *
     * - Returns: An array of localized weekday abbreviations, ordered according to the user's locale
     *
     * This function:
     * 1. Gets the user's current calendar with locale settings
     * 2. Determines the first day of the week from that locale
     * 3. Creates abbreviated weekday symbols in the correct order
     *
     * Example:
     * - US locale: ["S", "M", "T", "W", "T", "F", "S"] (starting with Sunday)
     * - UK locale: ["M", "T", "W", "T", "F", "S", "S"] (starting with Monday)
     */
    private func getLocalizedWeekdayLabels() -> [String] {
        let calendar = Calendar.current
        
        // Get the standard weekday symbols for the current locale
        let weekdaySymbols = calendar.veryShortWeekdaySymbols
        
        // Find which day is considered the first day of the week in this locale
        let firstWeekday = calendar.firstWeekday // 1 = Sunday, 2 = Monday, etc.
        
        // Reorder the array so it starts with the locale's first day of the week
        var orderedSymbols = [String]()
        
        // Add from firstWeekday to the end of the array
        for i in firstWeekday-1..<weekdaySymbols.count {
            orderedSymbols.append(weekdaySymbols[i])
        }
        
        // Add from beginning of array to firstWeekday-1
        for i in 0..<firstWeekday-1 {
            orderedSymbols.append(weekdaySymbols[i])
        }
        
        return orderedSymbols
    }
    
    /**
     * Gets the start date (Sunday) of the week containing the provided date.
     *
     * - Parameter for: The reference date to find the start of the week
     * - Returns: Date representing the start of the week (Sunday)
     *
     * Example:
     * If today is Thursday, April 17, 2025, this will return Sunday, April 13, 2025
     */
    private func getStartOfWeek(for date: Date = Date()) -> Date {
        let calendar = Calendar.current
        
        // Get the year and week number components from the date
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        
        // Create a new date with just those components
        // This gives us the first day of the week containing our date
        // By default, this is Sunday in the US calendar and Monday in many other locales
        guard let startOfWeek = calendar.date(from: components) else {
            // Fallback in case of error
            return calendar.date(byAdding: .day, value: -calendar.component(.weekday, from: date) + 1, to: date)!
        }
        
        return startOfWeek
    }
    
    /**
     * Filters workouts based on a specified time frame
     *
     * - Parameters:
     *   - workouts: The array of workouts to filter
     *   - timeFrame: The date range to filter by
     * - Returns: An array of workouts filtered to the specified time frame
     */
    private func filterWorkoutsByTimeFrame(workouts: [StairMasterWorkout], timeFrame: DateRange) -> [StairMasterWorkout] {
        
        switch timeFrame {
        //case .daily:
            //return []
            //return getDailyWorkouts(from: workouts)
        case .weekly:
            return getWeeklyWorkouts(from: workouts)
        case .monthly:
            return []
            //return getMonthlyWorkouts(from: workouts)
        case .yearly:
            return []
            //return getYearlyWorkouts(from: workouts)
        case .allTime:
            return workouts
        }
    }
    
    /**
     * Calculates the cumulative value for a specific metric from a collection of workouts.
     *
     * - Parameters:
     *   - workouts: The array of workouts to process
     *   - metric: The metric type to calculate
     * - Returns: The cumulative value for the specified metric
     */
    private func calculateCumulativeMetricFromWorkouts(workouts: [StairMasterWorkout], metric: StairmasterMetric) -> Double {
        var cumulativeValue: Double = 0
        
        for workout in workouts {
            switch metric {
            case .stepsClimbed:
                if let steps = workout.totalSteps {
                    cumulativeValue += Double(steps)
                }
            case .floorsClimbed:
                if let floors = workout.floorsClimbed {
                    cumulativeValue += Double(floors)
                }
            case .caloriesBurned:
                if let calories = workout.caloriesBurned {
                    cumulativeValue += calories
                }
            case .durationClimbed:
                cumulativeValue += workout.duration
            }
        }
        
        return cumulativeValue
    }
    
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
        
    /**
     * Filters workouts to only include those from the current week
     */
    private func getWeeklyWorkouts(from workouts: [StairMasterWorkout]) -> [StairMasterWorkout] {
        let calendar = Calendar.current
        let today = Date()
        return workouts.filter { workout in
            calendar.isDate(workout.date, equalTo: today, toGranularity: .weekOfYear) &&
            calendar.isDate(workout.date, equalTo: today, toGranularity: .yearForWeekOfYear)
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


#Preview {
    DashboardChartView(allWorkouts: [])
}
