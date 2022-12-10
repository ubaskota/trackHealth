//
//  ReviewView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//

import SwiftUI

struct ReviewView: View {
	@ObservedObject var mealItem: MealItem
	
	var body: some View {
		Text("Lamo Kera")
		
		List(mealItem.getMealFromCoreData()){ pInfo in
			Text(String(pInfo.foodOne!))
			Text(String(pInfo.totalCalories))
		}
	}
}


struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(mealItem: MealItem())
    }
}
