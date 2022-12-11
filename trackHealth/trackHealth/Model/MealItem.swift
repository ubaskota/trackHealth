//
//  MealItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/31/22.
//

import Foundation
import SwiftUI


class MealItem: NSObject, ObservableObject {
	
	let coreDM: DataController = DataController.shared
	
	override init() {
		super.init()
	}
	
	
	func getAverageCalorie(mealType: String) -> Int32 {
		var averageBreakfastCalories = 0
		var count = 0
		let mealInfo = getMealFromCoreData()
		for meal in mealInfo{
			if meal.mealType == mealType {
				averageBreakfastCalories += Int(meal.totalCalories)
				count += 1
			}
		}
		if count == 0{
			return Int32(averageBreakfastCalories)
		}
		return Int32(averageBreakfastCalories/count)
	}
	
	
	func saveMealToCoreData(mealType: String, foodOne: String, foodTwo: String, foodThree: String, foodFour: String, totalCalories: Int32) {
		coreDM.saveMealDataToCoreData(mealType: mealType, foodOne: foodOne, foodTwo: foodTwo, foodThree: foodThree, foodFour: foodFour, totalCalories: totalCalories)
	}
	
	
	func getMealFromCoreData() -> [Meal] {
		return coreDM.getMealDataFromCoreData()
	}
}
