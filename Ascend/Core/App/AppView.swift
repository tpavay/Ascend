//
//  AppView.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/4/25.
//

import SwiftUI

/*
 Requirements
    1. Displays the onboarding flow if the user has not completed on boarding.
    2. Displays the sign up/in screen if the user has completed on boarding and the user is signed out.
    3. Displays the tab bar view if the user is signed in and has completed onboarding.
    4. Keeps track of the information the user has filled out during onboarding including
        - the current page they are on
        - Their first name
        - Their last name
        - HealthKit authorization status
    5. If the user has completed onboarding then we should show them the TabBar view which displays the core app.


 Onboarding Flow
    - Questions:
        1. What data do I need to collect?

    - Actual Flow
        1. Get Started/Welcome Screen introducing the user to the app and prompting them to get started.
        2. Prompt the user for their first name
        3. Prompt the user for their last name
        4. Prompt the user to enable HealthKit access.

 Implementation
    1. Displays the onboarding flow if the user has not completed on boarding.
        - I could use user defaults. But, this makes our app dependent on user defaults and we ideally want our app to be dependency agnostic.
            So, instead we could create an AppState class that gets created when the app launches and encapsulates the properties that make
            up our app state. How is this persisted though?
        -
        - Track whether or not the user has completed onboarding using a user defaults boolean value.
        - Set this value to true once the user finishes the last step of onboarding
    2.




 Thoughts:
 1. might want to create an onboarding stepper view that keeps track of the current step and the other information the user enters. This would require persisting the information as the user types.
*/

struct AppView: View {
    @AppStorage("showTabBar") private var showTabBar = false

    var body: some View {
//        if showTabBar {
//            BottomBar()
//        }
//        else {
//            GetStartedView()
//        }
        BottomBar()
    }
}

#Preview {
    AppView()
}
