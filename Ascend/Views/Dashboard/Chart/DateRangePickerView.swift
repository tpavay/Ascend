//
//  DateRangePickerView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/14/25.
//

import SwiftUI

struct DateRangePickerView: View {
    @Binding var selectedDateRange: DateRange
    @Binding var selectedChartType: StairmasterMetric
    
    var body: some View {
        HStack() {
            ForEach(DateRange.allCases, id: \.self) { dateRange in
                Text(dateRange.description.capitalized)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(selectedDateRange == dateRange ? selectedChartType.color : .clear)
                    )
                    .foregroundColor(selectedDateRange == dateRange ? .white : .primary)
                    .onTapGesture {
                        selectedDateRange = dateRange
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var selectedDateRange: DateRange = .weekly
    @Previewable @State var selectedChartType: StairmasterMetric = .stepsClimbed
    DateRangePickerView(selectedDateRange: $selectedDateRange, selectedChartType: $selectedChartType)
}
