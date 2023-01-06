//
//  ReviewItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/12/22.
//

import Foundation
import SwiftUI

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
		let sleepScoreDates = coreDM.getSleepScoreDatesFromCoreData(scoreType: scoreType)
		return sleepScoreDates
	}
	
	
	func getAverageCaloriesOfDates(allDates: [Date]) -> Int32 {
		let averageCaloriesOfDates = coreDM.getAverageCaloriesOfDatesFromCoreData(allDates: allDates)
		return averageCaloriesOfDates
	}
	
	
	func getAverageWorkOutTimesOfDates(allDates: [Date]) -> Int32 {
		return coreDM.getAverageWorkOutOfDatesFromCoreData(allDates: allDates)
	}
	
	
	//In the future we need to be able to get the data for all workout types
	func getAllWorkOutOfDates(allDates: [Date]) -> [Int32] {
		return []
	}
	
	
	func getWeeklyCaloriesAndScore() -> [CalorieAndScore] {
		return coreDM.getWeeklyCaloriesAndScoreFromCoreData()
		//		return []
	}
	
	func getWeeklyPhysicalAndScore() -> [PhysicalAndScore] {
		return coreDM.getWeeklyPhysicalAndScoreFromCoreData()
		//		return []
	}
	
	
	//Gradient color in graph
	//	func arrangeWeeklyGradColor(physicalData: [PhysicalWeeklyData]) -> [LinearGradient] {
	//		var gradientToReturn: [LinearGradient] = []
	//		for shape in physicalData{
	//			if shape.condition == "Slept Well" {
	//				gradientToReturn =  [LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing), LinearGradient(colors: [.red, .pink,], startPoint: .leading, endPoint: .trailing)]
	//				break
	//			}
	//			else {
	//				gradientToReturn =  [LinearGradient(colors: [.red, .pink,], startPoint: .leading, endPoint: .trailing), LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)]
	//				break
	//			}
	//		}
	//		return gradientToReturn
	//	}
}

struct CalorieAndScore: Identifiable {
	var id = UUID()
	let calorie: Int32
	let score: String
	let date: String
}


struct PhysicalAndScore: Identifiable {
	var id = UUID()
	let workOutMins: Int32
	let score: String
	let date: String
}


struct DateAndTotalCalories: Identifiable {
	var id = UUID()
	let date: Date
	let totalCalories: Int32
}
