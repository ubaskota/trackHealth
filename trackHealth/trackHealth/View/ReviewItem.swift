//
//  ReviewItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/12/22.
//

import Foundation

class ReviewItem: NSObject, ObservableObject {
	let coreDM: DataController = DataController.shared
	
	override init() {
		super.init()
	}
	
	
	func getAverageCaloriesOfScore(scoreType: String) -> Int32 {
		let scoreDates = getSleepScoreDates(scoreType: scoreType)
		let averageCalories = getAverageCaloriesOfDates(allDates: scoreDates)
		return averageCalories
		
	}
	
	
	func getAverageWorkOutTimeOfScore(scoreType: String) -> Int32 {
		let scoreDates = getSleepScoreDates(scoreType: scoreType)
		let averageWorkOutTime = getAverageWorkOutTimesOfDates(allDates: scoreDates)
		return averageWorkOutTime
	}
	
	
	func getSleepScoreDates(scoreType: String) -> [Date]{
		return coreDM.getSleepScoreDatesFromCoreData(scoreType: scoreType)
	}
	
	
	func getAverageCaloriesOfDates(allDates: [Date]) -> Int32 {
		return coreDM.getAverageCaloriesOfDatesFromCoreData(allDates: allDates)
	}
	
	
	func getAverageWorkOutTimesOfDates(allDates: [Date]) -> Int32 {
		return coreDM.getAverageWorkOutOfDatesFromCoreData(allDates: allDates)
	}


	//In the future we need to be able to get the data for all workout types
	func getAllWorkOutOfDates(allDates: [Date]) -> [Int32] {
		return []
	}
}
