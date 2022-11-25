//
//  FoodView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/31/22.
//

import SwiftUI

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
	
	@State private var selection: String? = nil
	@State private var showingAddMeal = false
	@StateObject var allMeal_details = MealDetails()
	var bColor = "green"
	
    var body: some View {
		
		VStack {
			VStack {
				Text("Add your meal")
					.fontWeight(.bold)
					.font(.title)
					.font(.system(size: 20))
					.foregroundColor(.gray)
			}
			NavigationView {
				VStack (spacing: 30) {
					List {
						ForEach(allMeal_details.items) { item in
							HStack {
								VStack(alignment: .leading) {
									Text(item.mealType)
										.font(.headline)
									HStack {
										TestRow(arg1: item.foodOne, arg2: item.foodTwo ?? "", arg3: item.foodThree ?? "", arg4: item.foodFour ?? "", arg5: item.totalCalories)
									}
								}
							}
						}
						.onDelete(perform: removeItems)
					}
					
					.toolbar {
						Button {
							showingAddMeal = true
						} label : {
							Image(systemName: "plus")
						}
					}
					.sheet(isPresented: $showingAddMeal) {
						AddMealView(allMeal_details: allMeal_details)
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
				RoundedRectangle(cornerRadius: 40))
		}

    }
	
	func removeItems(at offsets: IndexSet) {
		allMeal_details.items.remove(atOffsets: offsets)
	}
}



struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}

