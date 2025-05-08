//
//  ViewExtensions.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/4/25.
//

import SwiftUI

extension View {
    /// Function used to hide the keyboard
    ///
    /// This function is can be used to hide the keyboard within any `View` in the app
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
