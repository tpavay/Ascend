//
//  CommonOnboardingView.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/4/25.
//

import SwiftUI

/*
 All the onboarding screens are going to have similar structure. and functionality. So, it makes sense to create a common component that accepts content to be shown in addition to the call to action button.


    We can use generics to except Content that conforms to view and display it.
    We can also except an action () -> Void that can be performed by the call to action button
 */
struct CommonOnboardingView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CommonOnboardingView()
}
