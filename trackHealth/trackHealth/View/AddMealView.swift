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
//				Text("Add the meal type")
//					.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
//					.padding([.top, .bottom])
//
				Picker("Meal", selection: $mealType) {
					ForEach(meals, id: \.self) {
						Text($0)
					}
				}
				.font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(Color.green)
				
				
				Text("Add All the Foods")
					.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
					.padding([.top, .bottom])
				TextField("Food One", text: $foodOne)
					.padding()
					.cornerRadius(20)
				TextField("Food Two", text: $foodTwo)
					.padding()
					.cornerRadius(20)
				TextField("Food Three", text: $foodThree)
					.padding()
					.cornerRadius(20)
				TextField("Food Four", text: $foodFour)
					.padding()
					.cornerRadius(20)
				
				Text("Total Calories")
					.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
					.padding([.top, .bottom])
				
				TextField("Total Calories", value: $total_calories, formatter: NumberFormatter())
					.keyboardType(.decimalPad)
					.padding()
					.cornerRadius(20)
			}
			.toolbar {
				Button("ADD") {
					let item = MealItem(mealType: mealType, foodOne: foodOne, foodTwo: foodTwo, foodThree: foodThree, foodFour: foodFour, totalCalories: Int(total_calories))
					allMeal_details.items.append(item)
					dismiss()
				}
				.font(.system(size: 20, weight: .bold, design: .default))
//				.foregroundColor(disableForm ? .white : .green)
				.disabled(foodOne.count < 3 && total_calories == 0)
			}
		}
    }
	
//	var disableForm: Bool {
//		if (foodOne.isEmpty) && (foodOne.count < 3) && (total_calories <= 0) {
//			return true
//		}
//		return false
//	}
}


struct AddMealView_Previews: PreviewProvider {
    static var previews: some View {
		AddMealView(allMeal_details: MealDetails())
    }
}
