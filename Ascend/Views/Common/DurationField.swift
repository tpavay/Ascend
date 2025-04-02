//
//  DurationField.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/1/25.
//

import SwiftUI

struct DurationField: View {
    @Binding var userEnteredDuration: String
    @State private var localDuration: String = ""
    @FocusState.Binding var focusedField: LogStairMasterWorkoutFormField?
    let field: LogStairMasterWorkoutFormField
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Duration")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            TextField("00:00", text: $userEnteredDuration)
                .keyboardType(.numberPad)
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(focusedField == field ? .accentPrimary : Color.secondary.opacity(0.3), lineWidth: 1)
                })
                .onChange(of: userEnteredDuration) { oldValue, newValue in
                    if !(newValue.count == 9 && String(newValue.prefix(1)) != "0") {
                        convertDuration()
                    }
                    else {
                        userEnteredDuration = oldValue
                    }
                }
                .focused($focusedField, equals: field)
        }
        
    }
    private func convertDuration() {
        guard !userEnteredDuration.isEmpty else {
            userEnteredDuration = ""
            return
        }
        
        var durationStringWithoutColons = userEnteredDuration.filter { "0123456789".contains($0) }
        
        // DO NOT REMOVE: These two checks format duration as MM:SS if the leading values are padding
        if durationStringWithoutColons.count == 5 && String(durationStringWithoutColons.prefix(2)) == "00" {
            durationStringWithoutColons = String(durationStringWithoutColons.suffix(4))
        }
        else if durationStringWithoutColons.count == 5 && String(durationStringWithoutColons.prefix(1)) == "0" {
            durationStringWithoutColons = String(durationStringWithoutColons.suffix(4))
        }

        guard let durationNumberWithoutColons = Int(durationStringWithoutColons) else {
            userEnteredDuration = localDuration
            return
        }
        
        // Format the duration based on the length
        if (durationStringWithoutColons.count <= 2) {
            localDuration = String(format: "00:%02d", durationNumberWithoutColons)
        }
        else if (durationStringWithoutColons.count <= 4) {
            let minutes = durationNumberWithoutColons / 100 // Minutes field is between 100-9999
            let seconds = durationNumberWithoutColons % 100 // Seconds field is between 0-99
            
            let adjustedMinutes = minutes + (seconds / 60)
            let adjustedSeconds = seconds % 60

            localDuration = String(format: "%02d:%02d", adjustedMinutes, adjustedSeconds)
        }
        else {
            // Format as HH:MM:SS: 11999 -> 01:19:99 -> 01:20:39
            var remainingValue = durationNumberWithoutColons
            
            // Extract hours, minutes, and seconds
            let hours = remainingValue / 10000
            remainingValue %= 10000
            
            let minutes = remainingValue / 100
            let seconds = remainingValue % 100
            
            // Handle overflow in seconds and minutes
            var adjustedSeconds = seconds
            var adjustedMinutes = minutes
            
            if adjustedSeconds >= 60 {
                adjustedMinutes += adjustedSeconds / 60
                adjustedSeconds %= 60
            }
            
            var adjustedHours = hours
            if adjustedMinutes >= 60 {
                adjustedHours += adjustedMinutes / 60
                adjustedMinutes %= 60
            }
            localDuration = String(format: "%02d:%02d:%02d", adjustedHours, adjustedMinutes, adjustedSeconds)
        }
        userEnteredDuration = localDuration
    }
}

#Preview {
    @Previewable @State var userEnteredDuration: String = ""
    @Previewable @FocusState var focusedField: LogStairMasterWorkoutFormField?
    DurationField(userEnteredDuration: $userEnteredDuration, focusedField: $focusedField, field: .duration)
}
