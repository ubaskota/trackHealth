//
//  MealItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/31/22.
//

import Foundation
import SwiftUI


class MealItem: NSObject, ObservableObject {
	
	var moc = DataController.init().container.viewContext
	@FetchRequest(entity: Meal.entity(), sortDescriptors: []) var mealInfo: FetchedResults<Meal>
	
	override init() {
		super.init()
	}
	
	func getAverageCalorie(mealType: String) -> Float {
		var averageBreakfastCalories = 0
		var count = 1
		for meal in mealInfo{
			if meal.mealType == mealType {
				averageBreakfastCalories += Int(meal.totalCalories)
				count += 1
			}
		}
		return Float(averageBreakfastCalories/count)
	}
}
