//
//  AuthState.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/28/25.
//

enum AuthState: Int, CaseIterable {
    case signedOut = 0
    case signedIn = 1
    case loading = 2
}
