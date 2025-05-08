//
//  GetHealthKitAuthorizationView.swift
//  Ascend
//
//  Created by Tyler Pavay on 5/4/25.
//

import SwiftUI

struct GetHealthKitAuthorizationView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Please authorize health kit")
                NavigationLink(
                    destination: BottomBar(),
                    label: {
                        Text("Finish")
                    }
                )
            }


        }
    }
}

#Preview {
    GetHealthKitAuthorizationView()
}
