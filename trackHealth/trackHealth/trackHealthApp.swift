//
//  trackHealthApp.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/25/22.
//

import SwiftUI

@main
struct trackHealthApp: App {
	@StateObject private var dataController = DataController()
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
