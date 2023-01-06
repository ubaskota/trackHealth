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
	
	
	//Sleep Related
	func saveSleepDataToCoreData(survey: Int16, fileName: String, sleepScore: Float, sleepStartTime: Date, sleepStopTime: Date, soundDb: [Double]) {
		
		let sleep = Sleep(context: container.viewContext)
		sleep.uuid = UUID()
		sleep.sleepFileName = fileName
		sleep.sleepScore = sleepScore
		sleep.sleepStartTime = sleepStartTime
		sleep.sleepStopTime = sleepStopTime
		sleep.survey = survey
		sleep.soundDb = soundDb
		
		do {
			try container.viewContext.save()
			print("Sucessfully saved sleeep data")
		} catch {
			print("Unexpected error saving sleep data: \(error).")
		}
	}
	
	
	func getSleepDataFromCoreData() -> [Sleep] {
		let fetchRequest: NSFetchRequest<Sleep> = Sleep.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		let sort = NSSortDescriptor(key: "sleepStartTime", ascending: false)
		fetchRequest.sortDescriptors = [sort]
		
		do {
			return try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while getting sleepdata: \(error.localizedDescription)")
			return []
		}
	}
	
	
	func getSleepDbDataArrayFromCoreData(recordDateTime: String) -> [Double] {
		var soundData: [Sleep]
		let fetchRequest: NSFetchRequest<Sleep> = Sleep.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		let filter = NSPredicate(format: "sleepFileName == %@", recordDateTime)
		fetchRequest.predicate = filter
		
		do {
			soundData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while fetching data from db array \(error.localizedDescription)")
			return []
		}
//		return soundData.soundDb
		for item in soundData {
			let returnItem = item.soundDb
			return returnItem!
		}
		return []
	}
	
	
	//Meal Related
	func saveMealDataToCoreData(mealType: String, foodOne: String, foodTwo: String, foodThree: String, foodFour: String, totalCalories: Int32) {
		
		let meal = Meal(context: container.viewContext)
		meal.uuid = UUID()
		meal.recordDate = Date()
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
	
	
	//Profile Related
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
	
	
	//WorkOut related
	func saveWorkOutDataToCoreData(weightsTotal: Int32, runWalkTotal: Float, sportsTotal: Int32) {
		let workout = Work(context: container.viewContext)
		workout.weightsTotal =  weightsTotal
		workout.sportsTotal = sportsTotal
		workout.runWalkTotal = runWalkTotal
		workout.recordDate = Date()
		
		do {
			try container.viewContext.save()
				print("Successfully saved workout date")
		} catch {
			print("Unexpected error in workout adddition: \(error).")
		}
	}
	
	
	func getWorkOutDataFromCoreData() -> [Work] {
		let fetchRequest: NSFetchRequest<Work> = Work.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		
		do {
			return try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while getting sleepdata: \(error.localizedDescription)")
			return []
		}
	}
	
	
	//Review analysis
	func getSleepScoreDatesFromCoreData(scoreType: String) -> [Date] {
//		let filter: NSPredicate
		var sleepData: [Sleep]
		var listDates: [Date] = []
//		let highScore: Float = 75.0
		
		let fetchRequest: NSFetchRequest<Sleep> = Sleep.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		
		if scoreType == "high" {
			let filter = NSPredicate(format: "sleepScore >= %@", "80")
			fetchRequest.predicate = filter
		}
		else {
			let filter = NSPredicate(format: "sleepScore < %@", "80")
			fetchRequest.predicate = filter
		}
//		fetchRequest.predicate = filter
		
		do {
			sleepData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while fetching data from db array \(error.localizedDescription)")
			return []
		}
		
		for item in sleepData {
			listDates.append(item.sleepStartTime!)
		}
		return listDates
	}
	
	
	func getAverageCaloriesOfDatesFromCoreData(allDates: [Date]) -> Int32 {
		let calorieData: [Meal]
		var total_calories: Int32 = 0
		var averageCalories: Int32
		var totalCount: Int32 = 0
//		let datesCount: Int = allDates.count
		
		let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
//		let filter = fetchRequest.predicate
		
		do {
			calorieData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while fetching data from db array \(error.localizedDescription)")
			return 0
		}

		for l_date in allDates {
			for item in calorieData{
				if item.recordDate?.toString(dateFormat: "dd-MM-YY") == l_date.toString(dateFormat: "dd-MM-YY") {
					total_calories += item.totalCalories
					totalCount += 1
				}
			}
		}
		if totalCount == 0{
			return total_calories
		}
		averageCalories = total_calories/totalCount
		return averageCalories
//		return 0
	}
	
	
	func getAverageWorkOutOfDatesFromCoreData(allDates: [Date]) -> Int32 {
		let workOutData: [Work]
		var totalTime: Int32 = 0
		var averageTime: Int32
		var totalCount: Int32 = 0
//		let datesCount: Int = allDates.count
		
		let fetchRequest: NSFetchRequest<Work> = Work.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
//		let filter = fetchRequest.predicate
		
		do {
			workOutData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("ERROR while fetching data from db array \(error.localizedDescription)")
			return 0
		}
		
		for l_date in allDates {
			for item in workOutData {
				if  item.recordDate?.toString(dateFormat: "dd-MM-YY") == l_date.toString(dateFormat: "dd-MM-YY") {
					totalTime += item.sportsTotal
					totalTime += item.weightsTotal
					totalTime += Int32(item.runWalkTotal * 20.0)
					totalCount += 1
				}
			}
		}
		if totalCount == 0 {
			return totalTime
		}
		averageTime = totalTime/totalCount
		return averageTime
	}
	
	//Weekly review
	func getWeeklyCaloriesAndScoreFromCoreData() -> [CalorieAndScore] {
		var weeklyCalorieScoreData: [CalorieAndScore] = []
		let todaysDate = Date()
		let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
		let weeklyCalorieData = getWeeklyCalorieDataFromCoreData(startDate: todaysDate, endDate: sevenDaysAgo)
		let weeklySleepData = getWeeklySleepDataFromCoreData(startDate: todaysDate, endDate: sevenDaysAgo)
		
//		for (cal, slp) in zip(weeklyCalorieData, weeklySleepData) {
////			print("This is cal date : \(String(describing: cal.recordDate))")
//			if cal.recordDate?.toString(dateFormat: "dd-MM-YY") == slp.sleepStartTime?.toString(dateFormat: "dd-MM-YY") {
//				let addDate = slp.sleepStartTime!.toString(dateFormat: "dd-MM-YY")
//				let score = slp.sleepScore <= 80 ? "low" : "high"
//				let toAdd = CalorieAndScore(calorie: cal.totalCalories, score: score, date: addDate)
//				weeklyCalorieScoreData.append(toAdd)
//			}
//		}
		
		var alreadyCheckedDate: [String] = []
		var countSoFar = 0

		for cal in weeklyCalorieData {
			for slp in weeklySleepData {
				let cal_onlyDate = cal.recordDate?.toString(dateFormat: "dd-MM-YY")
				let slp_onlyDate = slp.sleepStartTime?.toString(dateFormat: "dd-MM-YY")
				if countSoFar < 7 {
					if cal_onlyDate == slp_onlyDate {
						if alreadyCheckedDate.contains(cal_onlyDate!) || alreadyCheckedDate.contains(slp_onlyDate!) {
							continue
						}
						else {
							let addDate = slp.sleepStartTime!.toString(dateFormat: "LLL-dd")
							let score = slp.sleepScore <= 80 ? "low" : "high"
							let toAdd = CalorieAndScore(calorie: totalCaloriesForThatDay(givenDate: slp.sleepStartTime!), score: score, date: addDate)
							weeklyCalorieScoreData.append(toAdd)
							alreadyCheckedDate.append(slp_onlyDate!)
							countSoFar += 1
						}
					}
				}
			}
		}
		return weeklyCalorieScoreData
	}
	
	
	func totalCaloriesForThatDay(givenDate: Date) -> Int32 {
		var calorieData: [Meal] = []
//		var totalCaloriesAndDate: [DateAndTotalCalories]
//		var components = DateComponents()
//		components.hour = 0
//		components.minute = 0
//		components.second = 0
//		let date = Calendar.current.dateComponents([.month, .day, .month], from: givenDate)
		let startDate = Calendar.current.date(bySettingHour: 0, minute: 00, second: 0, of: givenDate)!
		print("This is start date : \(startDate)")
		let endDate =  Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: givenDate)!
		print("This is end date : \(endDate)")
		let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		let filter = NSPredicate(format: "recordDate <= %@ AND recordDate > %@", endDate as NSDate, startDate as NSDate)
		fetchRequest.predicate = filter
		
		do {
			calorieData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("Error while fetching data from db array \(error.localizedDescription)")
		}
		
		var totalCalories: Int32 = 0
		
		for calData in calorieData {
			totalCalories += calData.totalCalories
		}
		return totalCalories
	}
	
	
	func getWeeklyPhysicalAndScoreFromCoreData() -> [PhysicalAndScore] {
		var weeklyPhysicalScoreData: [PhysicalAndScore] = []
		let todaysDate = Date()
		let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
		let weeklyPhysicalData = getWeeklyPhysicalDataFromCoreData(startDate: todaysDate, endDate: sevenDaysAgo)
		let weeklySleepData = getWeeklySleepDataFromCoreData(startDate: todaysDate, endDate: sevenDaysAgo)
		
		
//		for (phl, slp) in zip(weeklyPhysicalData, weeklySleepData) {
//			if phl.recordDate?.toString(dateFormat: "dd-MM-YY") == slp.sleepStartTime?.toString(dateFormat: "dd-MM-YY") {
//				let addDate = slp.sleepStartTime!.toString(dateFormat: "dd-MM-YY")
//				let totalPhysicalTime = phl.sportsTotal + phl.weightsTotal + Int32(phl.runWalkTotal * 20.0)
//				let score = slp.sleepScore <= 80 ? "low" : "high"
//				let toAdd = PhysicalAndScore(workOutMins: totalPhysicalTime, score: score, date: addDate)
//				weeklyPhysicalScoreData.append(toAdd)
//			}
//		}
		var countSoFarOne = 0
		var alreadyCheckedDateOne: [String] = []
		for phl in weeklyPhysicalData {
			for slp in weeklySleepData {
				let phl_onlyDate = phl.recordDate?.toString(dateFormat: "dd-MM-YY")
				let slp_onlyDate = slp.sleepStartTime?.toString(dateFormat: "dd-MM-YY")
				if countSoFarOne < 7 {
					if phl_onlyDate == slp_onlyDate {
						if alreadyCheckedDateOne.contains(phl_onlyDate!) || alreadyCheckedDateOne.contains(slp_onlyDate!) {
							continue
						}
						else {
							let addDate = slp.sleepStartTime!.toString(dateFormat: "LLL-dd")
							let totalPhysicalTime = phl.sportsTotal + phl.weightsTotal + Int32(phl.runWalkTotal * 20.0)
							let score = slp.sleepScore <= 80 ? "low" : "high"
							let toAdd = PhysicalAndScore(workOutMins: totalPhysicalTime, score: score, date: addDate)
							weeklyPhysicalScoreData.append(toAdd)
							alreadyCheckedDateOne.append(slp_onlyDate!)
							countSoFarOne += 1
						}
					}
				}
			}
		}
		return weeklyPhysicalScoreData
	}
	
	
	func getWeeklyCalorieDataFromCoreData(startDate: Date, endDate: Date) -> [Meal] {
		
		var calorieData: [Meal]
		
		let fetchRequest: NSFetchRequest<Meal> = Meal.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		let filter = NSPredicate(format: "recordDate <= %@ AND recordDate > %@", startDate as NSDate, endDate as NSDate)
		let sort = NSSortDescriptor(key: "recordDate", ascending: false)
//		let filter = NSPredicate(format: "recordDate <= %@", startDate as NSDate)
		fetchRequest.predicate = filter
		fetchRequest.sortDescriptors = [sort]
		
		do {
			calorieData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("Error while fetching data from db array \(error.localizedDescription)")
			return []
		}
		return calorieData
	}
	
	
	func getWeeklySleepDataFromCoreData(startDate: Date, endDate: Date) -> [Sleep] {
		
		var sleepData: [Sleep]
		
		let fetchRequest: NSFetchRequest<Sleep> = Sleep.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		let filter = NSPredicate(format: "sleepStartTime <= %@ AND sleepStartTime > %@", startDate as NSDate, endDate as NSDate)
		let sort = NSSortDescriptor(key: "sleepStartTime", ascending: false)
		fetchRequest.predicate = filter
		fetchRequest.sortDescriptors = [sort]
		
		do {
			sleepData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("Error while fetching data from db array \(error.localizedDescription)")
			return []
		}
		return sleepData
	}
	
	
	func getWeeklyPhysicalDataFromCoreData(startDate: Date, endDate: Date) -> [Work] {
		
		var workOutData: [Work]
		
		let fetchRequest: NSFetchRequest<Work> = Work.fetchRequest()
		fetchRequest.returnsObjectsAsFaults = false
		let filter = NSPredicate(format: "recordDate <= %@ AND recordDate > %@", startDate as NSDate, endDate as NSDate)
		let sort = NSSortDescriptor(key: "recordDate", ascending: false)
		fetchRequest.predicate = filter
		fetchRequest.sortDescriptors = [sort]
		
		do {
			workOutData = try container.viewContext.fetch(fetchRequest)
		} catch let error {
			print("Error while fetching data from db array \(error.localizedDescription)")
			return []
		}
		return workOutData
	}
}

