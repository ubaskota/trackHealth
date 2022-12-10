//
//  DataController.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//

import Foundation
import CoreData


class DataController: ObservableObject {
	
	static var shared = DataController()
	let container = NSPersistentContainer(name: "HealthData")
	
	init() {
		container.loadPersistentStores(completionHandler: { description, error in
			if let error = error {
				print("Core data failed to laod: \(error.localizedDescription)")
			}
		})
	}
	
	
	func saveSleepDataToCoreData(survey: Int16, fileName: String, sleepScore: Float, sleepStartTime: Date, sleepStopTime: Date, soundDb: [Float]) {
		
		let sleep = Sleep(context: container.viewContext)
		sleep.uuid = UUID()
		sleep.sleepFileName = fileName
		sleep.sleepScore = sleepScore
		sleep.sleepStartTime = sleepStartTime
		sleep.sleepStopTime = sleepStopTime
		sleep.survey = survey
		
		do {
			try sleep.soundDb = try NSKeyedArchiver.archivedData(withRootObject: soundDb, requiringSecureCoding: true)
			print("Successfully saved..")
		}
		catch {
			print("Unexpected error: \(error).")
		}
		
		do {
			try container.viewContext.save()
			print("Sucessfully saved sleeep data")
		} catch {
			print("Unexpected error saving sleep data: \(error).")
		}
	}
	
	
	func saveMealDataToCoreData(mealType: String, foodOne: String, foodTwo: String, foodThree: String, foodFour: String, totalCalories: Int32) {
		
		let meal = Meal(context: container.viewContext)
		meal.uuid = UUID()
		meal.mealType = mealType
		meal.foodOne = foodOne
		meal.foodTwo = foodTwo
		meal.foodThree = foodThree
		meal.foodFour = foodFour
		meal.totalCalories = totalCalories
		
		do {
			try container.viewContext.save()
				print("Successfully saved meals...")
		} catch {
			print("Unexpected error in meal adddition: \(error).")
		}
	}
	
	
	func saveProfileDataToCoreData(displayName: String, age: Int16, race: String, height: Float, weight: Float, preExistingConditions: Bool) {
		
		let profile = Profile(context: container.viewContext)
		profile.uuid = UUID()
		profile.displayName = displayName
		profile.age = age
		profile.race = race
		profile.height = height
		profile.weight = weight
		profile.preExistingConditions = preExistingConditions
		
		do {
			try container.viewContext.save()
				print("Successfully saved meals...")
		} catch {
			print("Unexpected error in meal adddition: \(error).")
		}
	}
	
	
	func getSleepDataFromCoreData() -> [Sleep] {
		let fetchRequest: NSFetchRequest<Sleep> = Sleep.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		do {
			return try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while getting sleepdata: \(error.localizedDescription)")
			return []
		}
	}
	
	
	func getMealDataFromCoreData() -> [Meal] {
		let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		do {
			return try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while getting sleepdata: \(error.localizedDescription)")
			return []
		}
	}
	
	
	func getProfileDataFromCoreData() -> [Profile] {
		let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		do {
			return try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while getting sleepdata: \(error.localizedDescription)")
			return []
		}
	}
	
}
