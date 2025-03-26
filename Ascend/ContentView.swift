//
//  ContentView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //@Environment(\.authService) private var authService: AuthService
    /// User Defaults value used to determine whether or not this user has ever launched the app before
    @AppStorage("hasLaunchedAppBefore") private var hasLaunchedAppBefore = false
    
    var body: some View {
        if hasLaunchedAppBefore {
            BottomBar()
        }
        else {
            GetStartedView()
        }
    }
}

#Preview {
    ContentView()
}
