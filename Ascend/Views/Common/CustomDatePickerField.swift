//
//  CustomDatePickerField.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/31/25.
//

import SwiftUI

import SwiftUI

struct CustomDatePickerField: View {
    // MARK: - Properties
    
    /// Binding to the date value that will be updated
    @Binding var date: Date
    
    /// Optional label text
    var label: String?
    
    /// Control for the popover presentation
    @State private var isDatePickerPresented: Bool = false
    
    /// Customization properties
    var displayFormat: DateFormatter
    var pickerComponents: DatePickerComponents = [.date, .hourAndMinute]
    var accentColor: Color = .accentPrimary
    
    // MARK: - Initialization
    
    init(date: Binding<Date>,
         label: String? = nil,
         displayFormat: DateFormatter? = nil,
         pickerComponents: DatePickerComponents = [.date, .hourAndMinute]) {
        self._date = date
        self.label = label
        
        // Set default date formatter if none provided
        if let formatter = displayFormat {
            self.displayFormat = formatter
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            self.displayFormat = formatter
        }
        
        self.pickerComponents = pickerComponents
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Optional label
            if let label = label {
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Main interactive field
            HStack {
                // Date text
                Text(displayFormat.string(from: date))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 8)
                
                // Calendar icon
                Image(systemName: "calendar")
                    .foregroundStyle(accentColor)
                    .padding(.horizontal, 8)
            }
            .contentShape(Rectangle()) // Make the entire HStack tappable
            .onTapGesture {
                isDatePickerPresented.toggle()
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                    )
            )
            .popover(isPresented: $isDatePickerPresented, arrowEdge: .top) {
                VStack(spacing: 0) {
                    // Header
                    Text("Select Date")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                    
                    Divider()
                    
                    // Date Picker
                    DatePicker(
                        "",
                        selection: $date,
                        displayedComponents: pickerComponents
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
                    
                    Divider()
                    
                    // Buttons
                    HStack(spacing: 0) {
                        Button("Cancel") {
                            isDatePickerPresented = false
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                            .frame(height: 44)
                        
                        Button("OK") {
                            isDatePickerPresented = false
                        }
                        .foregroundColor(accentColor)
                        .frame(maxWidth: .infinity)
                    }
                    .font(.system(size: 16, weight: .medium))
                }
                .presentationCompactAdaptation(.popover)
                .frame(width: 300)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 8)
            }
        }
    }
}

#Preview("Light Mode") {
    @Previewable @State var date = Date()
    
    VStack(spacing: 20) {
        CustomDatePickerField(date: $date, label: "Workout Date")
        CustomDatePickerField(date: $date, label: "Workout Time", pickerComponents: [.hourAndMinute])
    }
    .padding()
}

#Preview("Dark Mode") {
    @Previewable @State var date = Date()
    
    VStack(spacing: 20) {
        CustomDatePickerField(date: $date, label: "Workout Date")
        CustomDatePickerField(date: $date, label: "Workout Time", pickerComponents: [.hourAndMinute])
    }
    .padding()
    .preferredColorScheme(.dark)
}
