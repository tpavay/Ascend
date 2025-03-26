//
//  SignUpWithEmailView.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/25/25.
//

import Observation
import SwiftUI


@Observable
class AuthViewModel {
    var email: String = ""
    var password: String = ""
    
    func createUser() {
        print("Creating user with email: \(email) and password \(password)")
    }
}

struct SignUpWithEmailView: View {
    @State private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle.weight(.heavy))
                TextField("Email", text: $authViewModel.email)
                    .textFieldStyle(.roundedBorder)
                SecureField("Password", text: $authViewModel.password)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            Button {
                authViewModel.createUser()
            }
            label : {
                Text("Sign Up")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.accentPrimary)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    SignUpWithEmailView()
}
