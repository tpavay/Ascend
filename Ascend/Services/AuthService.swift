//
//  AuthService.swift
//  Ascend
//
//  Created by Tyler Pavay on 2/27/25.
//

import Observation
import FirebaseAuth
import SwiftData
import SwiftUI // Access to @AppStorage

/// This Authentication Service should:
/// 1. Manage User State
///     In order to manage the user state we need a class that represents a user. This is a class because we want one reference to the user on the heap
///     What do we need to keep track of for the user?
///     id, email, password, displayName, photoURL,
/// 2. Manage the User signed in status
///     AuthStatus enum could support this: signedIn, signedOut, or loading
/// 3. Handle all authentication logic
///     Using the Firebase auth instance that should be encapsulated in this class
/// 4. Be Injected as a singleton as an environment variable of the root view
///     Then any view that wants to access it can pull it from the Environment and inject it into the view model
@Observable
class AuthService {
    
    private let modelContext: ModelContext
    var user: User?
    var authState: AuthState = .loading
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// What we need
    /// 1. ModelContext injected so we can check if a local user already exists using the modelContext fetch capabiliteis.
    /// 2. A user property so we can keep track of the user and not have to retrieve it from SwiftData/Firebase over and over again. The user property will also keep track of if the user is anonymous or not via the isAnonymous property
    /// 3. An authentication state that allows us to determine if the user is signedIn, signedOut, or if they are actively signing in or out (loading)
    /// 4. Ability to determine if there is internet connection?
    /// 5. Whether or not this is the first time the app has been launched. This will be
}
