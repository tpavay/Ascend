//
//  LabeledTextField.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/25/25.
//

import SwiftUI

struct LabeledTextField: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var field: LogStairMasterWorkoutFormField
    @FocusState.Binding var focusedField: LogStairMasterWorkoutFormField?
    
    var body: some View {
        VStack {
            Text(label)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if isSecure {
                SecureField("", text: $text)
            }
            else {
                TextField(placeholder, text: $text)
                    .padding()
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(focusedField == field ? .accentPrimary : Color.secondary.opacity(0.3), lineWidth: 1)
                    })
                    .focused($focusedField, equals: field)
                    .autocorrectionDisabled()
            }
        }
    }
}

#Preview {
    @Previewable @State var text = ""
    @Previewable @FocusState var focusedField: LogStairMasterWorkoutFormField?
    
    LabeledTextField(label: "Duration", placeholder: "00:00", text: $text, isSecure: false, field: .duration, focusedField: $focusedField)
}

