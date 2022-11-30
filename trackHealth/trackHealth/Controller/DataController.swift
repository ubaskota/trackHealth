//
//  DataController.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//

import Foundation
import CoreData


class DataController: ObservableObject {
	
	let container = NSPersistentContainer(name: "HealthData")
	
	init() {
		container.loadPersistentStores(completionHandler: { description, error in
			if let error = error {
				print("Core data failed to laod: \(error.localizedDescription)")
			}
		})
	}
}
