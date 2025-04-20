//
//  TabView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/21/25.
//
import SwiftUI

struct BottomBar: View {
    
    var body: some View {
        TabView() {
            DashboardView()
                .tabItem() {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
            WorkoutMainView()
                .tabItem {
                    VStack {
                        Image(systemName: "figure.stair.stepper")
                        Text("Workout")
                            
                    }
                    
                }
            
            ProfileMainView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
        }
    }
}

#Preview {
    BottomBar()
}
