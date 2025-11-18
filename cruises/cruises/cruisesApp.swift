//
//  cruisesApp.swift
//  cruises
//
//  Created by Thomas Daly on 7/5/25.
//

import SwiftUI

@main
struct cruisesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for : Activity.self)
    }
}
