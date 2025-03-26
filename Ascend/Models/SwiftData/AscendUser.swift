//
//  User.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/5/25.
//

import Foundation
import SwiftData

/// A model representing a user of the Ascend application
///
/// This model is persisted using SwiftData and contains essential user information.
@Model
class AscendUser {
    
    /// The unique identifier for the user
    ///
    /// This attribute is marked as unique using SwiftData's attribute system. To ensure
    /// no two users have the same id. This id is used for user identification throughout
    /// the app and for relationships with other data models.
    @Attribute(.unique)
    var id: UUID
    
    /// The first name of the user
    ///
    /// This attribute is optional because it is possible we don't know the user's first name
    /// due to anonymous authentication. The firstName will be used as a display value
    /// in views throughout the app.
    var firstName: String?
    
    /// The last name of the user
    ///
    /// This attribute is optional because it is possible we don't know the user's last name
    /// due to anonymous authentication. The lastName will be used as a display value
    /// in views throughout the app.
    var lastName: String?
    
    /// Whether or not the user has been anonymously authenticated
    ///
    /// This attribute allows us to determine if the user has been authenticated anonymously or
    /// if they have explcitly signed up via a different authentication method such as with Apple,
    /// Google, or email/password
    var isAnonymous: Bool
    
    /// The URL associated with the Ascend user's profile picture
    ///
    /// This attribute will determine the profile picture of the user to be displayed throughout the app.
    /// Can be nil.
    var profilePictureURL: String?
    
    /// Default initializer
    ///
    /// Parameters:
    /// - id: The unique id of the user. Defaults to a new UUID if not provided.
    /// - firstName: The optional first name of the user. Defaults to nil
    /// - lastName: The optional last name of the user. Defaults to nil
    /// - isAnonymous: Whether or not the user has been authenticated anonymously. Defaults to true.
    /// - profilePictureURL: The string value associated with the user's profile picture
    init(id: UUID = UUID(), firstName: String? = nil, lastName: String? = nil, isAnonymous: Bool = true, profilePictureURL: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.isAnonymous = isAnonymous
        self.profilePictureURL = profilePictureURL
    }
}
