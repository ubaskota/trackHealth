//
//  AddMealView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 6/1/22.
//

import SwiftUI

struct AddMealView: View {
	@ObservedObject var allMeal_details: MealDetails
	@Environment(\.dismiss) var dismiss
	
	@State private var mealType = ""
	let meals = ["Breakfast", "Lunch", "Dinner", "Snacks"]
	
	@State private var foodOne = ""
	@State private var foodTwo = ""
	@State private var foodThree = ""
	@State private var foodFour = ""
	@State private var total_calories = 0.0
	
    var body: some View {
		
		NavigationView {
			Form {
				Section(header: Text("MEAL TYPE")) {
					Picker("Meal", selection: $mealType) {
						ForEach(meals, id: \.self) {
							Text($0)
						}
					}
				}
				
				Section(header: Text("Add All the Foods")) {
					TextField("Food One", text: $foodOne)
					TextField("Food Two", text: $foodTwo)
					TextField("Food Three", text: $foodThree)
					TextField("Food Four", text: $foodFour)
				}
				
				Section(header: Text("Total Calories")) {
					TextField("Total Calories", value: $total_calories, formatter: NumberFormatter())
						.keyboardType(.decimalPad)
				}
				
			}
			.navigationTitle("Add Your Meals")
			.toolbar {
				Button("ADD") {
					let item = MealItem(mealType: mealType, foodOne: foodOne, foodTwo: foodTwo, foodThree: foodThree, foodFour: foodFour, totalCalories: Int(total_calories))
					allMeal_details.items.append(item)
					dismiss()
				}
			}
		}
    }
}


struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
		AddMealView(allMeal_details: MealDetails())
    }
}
