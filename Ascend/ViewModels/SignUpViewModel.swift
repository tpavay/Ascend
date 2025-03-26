//
//  SignUpViewModel.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/3/25.
//
import Observation

@Observable
class SignUpViewModel {
    private var authService: AuthService
    var email = ""
    var password = ""
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
//    func createUser() {
//        Task {
//            authService.createUser()
//        }
//    }
}

