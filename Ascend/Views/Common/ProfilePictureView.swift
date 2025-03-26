//
//  ProfilePictureView.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/10/25.
//

import SwiftUI

struct ProfilePictureView: View {
    private let url: String?
    
    init(url: String?) {
        self.url = url
    }
    
    var body: some View {
        if url != nil && url != "" {
            // Show the profile picture associated with the URL
        }
        else {
            NavigationLink(destination: ProfileMainView()) {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 25)
                    .padding()
                    .background(.accentPrimary.opacity(0.3))
                    .clipShape(Circle())
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    NavigationStack {
        ProfilePictureView(url: "")
    }

}
