//
//  GetStartedView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/25/25.
//

import SwiftData
import SwiftUI

struct GetStartedView: View {
    /// The model context used to persist the anonymous user when they first open the app
    @Environment(\.modelContext) private var modelContext: ModelContext
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundImage
                content
            }
        }
    }
    
    var backgroundImage: some View {
        ZStack {
            Image("GetStartedBackgroundPhoto")
                .resizable()
                .ignoresSafeArea()
            
            // Dark color overlay
            Color.black.opacity(0.3)
                .ignoresSafeArea()
        }
    }
    
    var content: some View {
        VStack(spacing: 20) {
            // Push this stack to the bottom
            Spacer()
            titleAndSubtitle
            NavigationLink(
                destination: GetFirstNameView(),
                label: {
                    Text("Get Started")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                        )
                }
            )
        }
        .padding()
    }
    
    var titleAndSubtitle: some View {
        VStack {
            // App name and tagline
            Text("ASCEND")
                .font(.largeTitle.weight(.heavy))
                .foregroundStyle(.white)
            
            Text("Climb. Track. Breakthrough.")
                .font(.callout.weight(.medium))
                .foregroundStyle(.white)
        }
    }

    /// Call-to-action button that creates a new anonymous user when pressed
//    var ctaButton: some View {
//        CustomTextButton(buttonText: "Get Started",
//                         buttonTextColor: .white,
//                         fillColor: .accentPrimary,
//                         isBorderedButton: false,
//                         action: createNewAnonymousUser)
//    }
    
    /// Function that creates a new AscendUser and inserts it into the SwiftData database
    ///
    /// The Ascend user is anonymous by default. This function also updates the hasLaunchedAppBefore
    /// to true in UserDefaults so that the Get Started page isn't shown to the user again after they first
    /// launch.
//    private func createNewAnonymousUser() {
//        let user = AscendUser()
//        modelContext.insert(user)
//        UserDefaults.standard.set(true, forKey: "hasLaunchedAppBefore")
//    }
}

#Preview {
    GetStartedView()
}
