//
//  ErrorView.swift
//  Ascend
//
//  Created by Tyler Pavay on 4/21/25.
//

import SwiftUI

struct ErrorView: View {
    let errorText: String
    let errorDescription: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "x.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 55)
                .foregroundStyle(.red)
            Text(errorText)
                .font(.title2.weight(.bold))
                .foregroundStyle(Color(UIColor.label))
            Text(errorDescription)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
        .padding()
    }
}

#Preview {
    ErrorView(errorText: "HealthKit Not Available", errorDescription: "This device doesn't support HealthKit integration, which means workout importing is unavailable.")
}
