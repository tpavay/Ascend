//
//  StairmasterDataPoint.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//

import Foundation

/// Represents a stair master data point to be plotted on a chart
struct StairmasterDataPoint: Identifiable {
    /// id: Unique identifier for the given data point
    var id = UUID()
    
    /// date: The date that the metric occurred
    var date: Date
    
    /// value: The value of the given data point
    var value: Int
    
    /// metric: The type of stairmaster metric
    var metricType: StairmasterMetric
}
