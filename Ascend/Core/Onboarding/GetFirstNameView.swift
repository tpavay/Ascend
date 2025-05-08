//
//  GetFirstNameView.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/4/25.
//

import SwiftUI

/*
 Requirements
     1. User is prompted to enter their first name
     2. User is able to enter their first name
     3. Next button is disabled if the user has not entered their
 first name.
    4. Next button is enabled if the user has entered their first name
 */
struct GetFirstNameView: View {
    @State private var firstName: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            content
        }
    }

    private var textFieldLabel: some View {
        Text("Please enter your first name")
            .font(.title.weight(.bold))
    }

    private var textField: some View {
        TextField("First Name", text: $firstName)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? .accent : Color(UIColor.label), lineWidth: 2)
            )
            .focused($isFocused)
    }

    private var nextButton: some View {
        NavigationLink(
            destination: GetLastNameView(),
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
        .disabled(firstName.isEmpty)
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
    GetFirstNameView()
}
