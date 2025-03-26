//
//  AscendApp.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/8/25.
//

import SwiftUI

@main
struct AscendApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [AscendUser.self, StairMasterWorkout.self])
        }
    }
}
