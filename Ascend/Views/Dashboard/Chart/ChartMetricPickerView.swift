//
//  ChartMetricPickerView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/14/25.
//

import SwiftUI

struct ChartMetricPickerView: View {
    @Binding var selectedChartType: StairmasterMetric
    
    var body: some View {
        HStack {
            ForEach(StairmasterMetric.allCases, id: \.self) { metric in
                Text(metric.description)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(selectedChartType == metric ? metric.color : Color.clear)
                    )
                    .foregroundColor(selectedChartType == metric ? .white : .primary)
                    .onTapGesture {
                        selectedChartType = metric
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedChartType: StairmasterMetric = .stepsClimbed
    
    ChartMetricPickerView(selectedChartType: $selectedChartType)
}
