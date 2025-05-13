//
//  LabelTextEditorView.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/25/25.
//

import SwiftUI

struct LogWorkoutTextEditorView: View {
    @Binding var notes: String
    var field: LogStairMasterWorkoutFormField
    @FocusState.Binding var focusedField: LogStairMasterWorkoutFormField?
    
    var body: some View {
        ZStack {
            // Notes
            TextEditor(text: $notes)
                .padding([.top, .leading], 8)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            focusedField == .notes ? Color.accentPrimary : Color.gray.opacity(0.3),
                            lineWidth: 1
                        )
                }
                .frame(height: 125)
                .scrollContentBackground(.hidden) // DO NOT REMOVE this gets rid of the ugly black box when in dark mode
                .focused($focusedField, equals: .notes)
                .autocorrectionDisabled()
            if focusedField != .notes && notes.isEmpty {
                Text("How'd it go? Share more about your stairmaster workout. (Optional)")
                    .foregroundStyle(.gray.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, -50)
                    .allowsTightening(false)
            }
        }
    }
}

#Preview("Light Mode") {
    @Previewable @State var notes: String = ""
    @Previewable @FocusState var focusedField: LogStairMasterWorkoutFormField?
    Form {
        ScrollView {
            LogWorkoutTextEditorView(notes: $notes, field: .notes, focusedField: $focusedField)
        }
    }
    .preferredColorScheme(.light)
    
}

#Preview("Dark Mode") {
    @Previewable @State var notes: String = ""
    @Previewable @FocusState var focusedField: LogStairMasterWorkoutFormField?
    Form {
        ScrollView {
            LogWorkoutTextEditorView(notes: $notes, field: .notes, focusedField: $focusedField)
        }
    }
    .preferredColorScheme(.dark)
}
