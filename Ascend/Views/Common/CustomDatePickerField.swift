//
//  CustomDatePickerField.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/31/25.
//

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
                    .foregroundStyle(.accentPrimary)
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
            .sheet(isPresented: $isDatePickerPresented) {
                DatePickerSheetContent(
                    date: $date,
                    isPresented: $isDatePickerPresented,
                    pickerComponents: pickerComponents
                )
            }
            .prefersPersistentSystemOverlaysHidden()
        }
    }
}

// Separate view for the sheet content
struct DatePickerSheetContent: View {
    @Binding var date: Date
    @Binding var isPresented: Bool
    var pickerComponents: DatePickerComponents
    
    // Store the original date when the sheet opens
    @State private var tempDate: Date = Date()

    var body: some View {
        VStack(spacing: 0) {
            // Header
            Text("Select Date")
                .frame(maxWidth: .infinity)
                .padding(.top, 50)
                .font(.headline)
                .fontWeight(.semibold)

            // Date Picker - using tempDate instead of directly binding to the real date
            DatePicker(
                "",
                selection: $tempDate,
                in: Calendar.current.date(byAdding: .year, value: -1, to: date)!...date,
                displayedComponents: pickerComponents
            )
            .datePickerStyle(.wheel)
            .labelsHidden()
            Spacer()
            Divider()
            
            // Button row
            HStack {
                Button(action: {
                    // Close sheet without applying changes
                    // No need to modify date since we were working with tempDate
                    isPresented = false
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundStyle(Color(UIColor.label))
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                }
                
                // Properly styled vertical divider
                Rectangle()
                    .fill(Color(UIColor.separator))
                    .frame(width: 0.5, height: 56)
                
                Button(action: {
                    // Apply the temp date to the actual binding and close sheet
                    date = tempDate
                    isPresented = false
                }) {
                    Text("OK")
                        .font(.headline)
                        .foregroundStyle(.accentPrimary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .presentationDetents([.fraction(0.4)])
        .presentationDragIndicator(.visible)
    }
}

// MARK: - Preview
#Preview("Light Mode") {
    @Previewable @State var date = Date()
    Form {
        ScrollView {
            VStack(spacing: 20) {
                CustomDatePickerField(date: $date, label: "Workout Date")
                CustomDatePickerField(date: $date, label: "Workout Time", pickerComponents: [.hourAndMinute])
            }
            .padding()
        }
    }
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
