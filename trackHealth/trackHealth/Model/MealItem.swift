//
//  MealItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/31/22.
//

import Foundation


struct MealItem: Identifiable, Codable {
	var id = UUID()
	let mealType: String
	let foodOne: String
	let foodTwo: String?
	let foodThree: String?
	let foodFour: String?
	let totalCalories: Int
}
