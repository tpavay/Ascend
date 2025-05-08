//
//  KeyboardDismissButton.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/4/25.
//

import SwiftUI

struct KeyboardDismissButton: View {
    var body: some View {
        HStack {
            // Push image to the right within toolbar
            Spacer()
            Image(systemName: "keyboard.chevron.compact.down")
                .foregroundStyle(.accentPrimary)
                .padding(.trailing)
                .onTapGesture {
                    hideKeyboard()
                }
        }
    }
}

#Preview {
    KeyboardDismissButton()
}
