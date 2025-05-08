//
//  GetLastNameView.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/4/25.
//

import SwiftUI

struct GetLastNameView: View {
    @State private var lastName: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            content
        }
    }

    private var textFieldLabel: some View {
        Text("Please enter your last name")
            .font(.title.weight(.bold))
    }

    private var textField: some View {
        TextField("Last Name", text: $lastName)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? .accent : Color(UIColor.label), lineWidth: 2)
            )
            .focused($isFocused)
    }

    private var nextButton: some View {
        NavigationLink(
            destination: GetHealthKitAuthorizationView(),
            label: {
                Text("Next")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                    )
            }
        )
        .disabled(lastName.isEmpty)
    }

    private var textFieldAndLabel: some View {
        VStack {
            textFieldLabel
            textField
        }
        .frame(maxHeight: .infinity)
    }

    private var content: some View {
        VStack {
            textFieldAndLabel
            nextButton
        }
        .toolbar {
            ToolbarItem(placement: .keyboard, content: { KeyboardDismissButton() })
        }
        .padding()
    }
}

#Preview {
    GetLastNameView()
}
