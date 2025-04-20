//
//  ChartDataHelper.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import Foundation

struct ChartDataHelper {
    static func createStepsData() -> [StairmasterDataPoint] {
        return
            [
                .init(date: Date.from(month: 1, day: 1, year: 2025), value: 400,  metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 3, year: 2025), value: 1000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 5, year: 2025), value: 2000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 7, year: 2025), value: 500, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 8, year: 2025), value: 1000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 11, year: 2025), value: 3000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 14, year: 2025), value: 1000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 15, year: 2025), value: 1000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 16, year: 2025), value: 1000, metricType: .stepsClimbed),
                .init(date: Date.from(month: 1, day: 20, year: 2025), value: 2500, metricType: .stepsClimbed)
            ]
    }
    
    static func createFloorsClimbedData() -> [StairmasterDataPoint] {
        return
            [
                .init(date: Date.from(month: 1, day: 1, year: 2025) , value: 32, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 3, year: 2025) , value: 25, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 5, year: 2025) , value: 10, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 7, year: 2025) , value: 60, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 8, year: 2025) , value: 100, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 11, year: 2025), value: 60, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 14, year: 2025), value: 103, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 15, year: 2025), value: 99, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 16, year: 2025), value: 85, metricType: .floorsClimbed),
                .init(date: Date.from(month: 1, day: 20, year: 2025), value: 40, metricType: .floorsClimbed),
            ]
    }
    
    static func createCaloriesBurnedData() -> [StairmasterDataPoint] {
        return
            [
                .init(date: Date.from(month: 1, day: 1, year: 2025) , value: 250, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 3, year: 2025) , value: 400, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 5, year: 2025) , value: 600, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 7, year: 2025) , value: 100, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 8, year: 2025) , value: 300, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 11, year: 2025), value: 700, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 14, year: 2025), value: 103, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 15, year: 2025), value: 99, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 16, year: 2025), value: 500, metricType: .caloriesBurned),
                .init(date: Date.from(month: 1, day: 20, year: 2025), value: 446, metricType: .caloriesBurned),
            ]
    }
    
    static func createDurationClimbedData() -> [StairmasterDataPoint] {
        return
            [
                .init(date: Date.from(month: 1, day: 1, year: 2025) , value: 30, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 3, year: 2025) , value: 10, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 5, year: 2025) , value: 40, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 7, year: 2025) , value: 10, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 8, year: 2025) , value: 100, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 11, year: 2025), value: 15, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 14, year: 2025), value: 15, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 15, year: 2025), value: 15, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 16, year: 2025), value: 30, metricType: .durationClimbed),
                .init(date: Date.from(month: 1, day: 20, year: 2025), value: 20, metricType: .durationClimbed)
            ]
    }
    
    static func createStepsChartData() -> [ChartDataPoint] {
        var data: [ChartDataPoint] = []
        
        data.append(ChartDataPoint(date: Date(), value: 1000))
        data.append(ChartDataPoint(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, value: 1500))
        data.append(ChartDataPoint(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, value: 3000))
        data.append(ChartDataPoint(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, value: 1000))
        data.append(ChartDataPoint(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, value: 500))
        data.append(ChartDataPoint(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, value: 2500))
        data.append(ChartDataPoint(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, value: 5500))
        
        return data
    }
}
