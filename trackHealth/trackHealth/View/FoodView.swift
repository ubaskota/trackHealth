//
//  FoodView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/31/22.
//

import SwiftUI
import CoreData

struct TestRow: View {
	var arg1: String = ""
	var arg2: String = ""
	var arg3: String = ""
	var arg4: String = ""
	var arg5: Int
	
	var body: some View {
		HStack {
			if arg5 < 600 {
				Text(arg1)
				Text(arg2)
				Text(arg3)
				Text(arg4)
			}
		}
		.background(Color.purple)
		HStack {
			if arg5 > 1000 {
				Text(arg1)
				Text(arg2)
				Text(arg3)
				Text(arg4)
			}
		}
		.background(Color.red)
		HStack {
			if (arg5 < 1000 && arg5 > 600) {
					Text(arg1)
					Text(arg2)
					Text(arg3)
					Text(arg4)
						.background(Color.green)
				}
			}
		.background(Color.green)
	}
}


struct FoodView: View {
	
//	@State private var selection: String? = nil
	@State private var showingAddMeal = false
//	@StateObject var allMeal_details = MealDetails()
	@ObservedObject var mealItem: MealItem
//	@FetchRequest(entity: Meal.entity(), sortDescriptors: []) var mealInfo: FetchedResults<Meal>
//	var bColor = "green"
	
    var body: some View {
		VStack {
			VStack {
				Text("Add your meal")
					.fontWeight(.bold)
					.font(.title)
					.font(.system(size: 20))
					.foregroundColor(.green)
			}
			.padding(.vertical)
			.frame(maxWidth: 430, maxHeight: 80)
			.scaledToFill()
			.background(.lightBackground)
			
			NavigationView {
				VStack (spacing: 30) {
					Text("Your average calorie intake so far: ")
					Text("Breakfast : \(mealItem.getAverageCalorie(mealType: "Breakfast")) Calories")
					Text("Lunch : \(mealItem.getAverageCalorie(mealType: "Lunch")) Calories")
					Text("Dinner : \(mealItem.getAverageCalorie(mealType: "Dinner")) Calories")
					Text("Snacks : \(mealItem.getAverageCalorie(mealType: "Snacks")) Calories")
					.toolbar {
						Button {
							showingAddMeal = true
						} label : {
							Image(systemName: "plus")
								.renderingMode(.original) // <1>
								.font(.system(size: 60))
								.foregroundColor(Color(.systemRed))
						}
					}
					.sheet(isPresented: $showingAddMeal) {
						AddMealView(mealItem: MealItem())
					}
				}
			}
			
			ZStack {
				Image("healthy")
					.resizable()
					.scaledToFit()
					.edgesIgnoringSafeArea(.all)
					.frame(width: 180, height: 130)
					.clipShape(Ellipse())
			}
			.background(
//				RoundedRectangle(cornerRadius: 40)
				Ellipse()
					.frame(width: 50, height: 50))
		}

    }
	
//	func removeItems(at offsets: IndexSet) {
//		allMeal_details.items.remove(atOffsets: offsets)
//	}
}


struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(mealItem: MealItem())
    }
}

