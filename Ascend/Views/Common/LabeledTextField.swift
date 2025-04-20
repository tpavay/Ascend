//
//  LabeledTextField.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/25/25.
//

import SwiftUI

struct LabeledTextField: View {
    /// The label that appears above the `TextField`
    var label: String
    
    /// The placeholder text that appears within the `TextField` when the bound text is empty
    var placeholder: String
    
    /// The text the user enters into the field
    @Binding var text: String
    
    /// Whether or not the field is a secure field
    var isSecure: Bool = false
    
    /// Whether or not the field is optional
    var isOptional: Bool = false
    
    /// The form field associated with this `TextField`. Used for focusing the `TextField`
    var field: LogStairMasterWorkoutFormField
    
    /// The forms currently focusedField. Used with the `field` property to properly focus this
    /// field when it's selected
    @FocusState.Binding var focusedField: LogStairMasterWorkoutFormField?
    
    var body: some View {
        VStack {
            textFieldLabel

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
    
    private var textFieldLabel: some View {
        HStack {
            labelText
            optionalText
        }
        .lineLimit(1)
    }
    
    private var labelText: some View {
        Text(label)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subheadline)
            .foregroundStyle(Color(UIColor.secondaryLabel))
    }
    
    @ViewBuilder
    private var optionalText: some View {
        isOptional ? Text("(Optional)").font(.caption).fontWeight(.light).foregroundStyle(Color(UIColor.tertiaryLabel)) : Text("")
    }
}

#Preview("Light Mode") {
    @Previewable @State var durationText = ""
    @Previewable @State var totalStepsText = ""
    @Previewable @FocusState var focusedField: LogStairMasterWorkoutFormField?
    
    Form {
        ScrollView {
            LabeledTextField(label: "Duration", placeholder: "00:00", text: $durationText, field: .duration, focusedField: $focusedField)
            LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalStepsText, isOptional: true, field: .totalSteps, focusedField: $focusedField)
            
            HStack {
                LabeledTextField(label: "Duration", placeholder: "00:00", text: $durationText, field: .duration, focusedField: $focusedField)
                LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalStepsText, isOptional: true, field: .totalSteps, focusedField: $focusedField)
            }
        }
    }
    .preferredColorScheme(.light)

}

#Preview("Dark Mode") {
    @Previewable @State var durationText = ""
    @Previewable @State var totalStepsText = ""
    @Previewable @FocusState var focusedField: LogStairMasterWorkoutFormField?
    
    Form {
        ScrollView {
            LabeledTextField(label: "Duration", placeholder: "00:00", text: $durationText, field: .duration, focusedField: $focusedField)
            LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalStepsText, isOptional: true, field: .totalSteps, focusedField: $focusedField)
            
            HStack {
                LabeledTextField(label: "Duration", placeholder: "00:00", text: $durationText, field: .duration, focusedField: $focusedField)
                LabeledTextField(label: "Total Steps", placeholder: "0", text: $totalStepsText, isOptional: true, field: .totalSteps, focusedField: $focusedField)
            }
        }
    }
    .preferredColorScheme(.dark)
}

