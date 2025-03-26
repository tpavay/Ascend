//
//  PreviewContainer.swift
//  Ascend
//
//  Created by Tyler Pavay on 3/18/25.
//

import SwiftData
import SwiftUI

/// Struct that is used to set up a SwiftData container that allows you to work with #Preview
struct PreviewContainer {
    let container: ModelContainer
    
    init(_ types: [any PersistentModel.Type], isStoredInMemoryOnly: Bool = true) {
        // Create schema from provided SwiftData model types
        let schema = Schema(types)
        
        // Create configuration that determines where the data for this Preview Container is stored
        let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        
        // Create the container using the schema and the config
        container = try! ModelContainer(for: schema, configurations: [config])
    }
}
