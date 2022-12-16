//
//  ReviewView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//

import SwiftUI
import Charts


struct CaloriesData: Identifiable {
	var id = UUID()
	var averageCalories: Int32
	var condition: String
}


struct PhysicalData: Identifiable {
	var id = UUID()
	var averageMinutes: Int32
	var condition: String
	
}


//@available(iOS 16.0, *)
struct ReviewView: View {
//	@ObservedObject var reviewItem: ReviewItem
//	var averageCalories: Int32
	var caloriesVSsleep: [CaloriesData]
	
	init(reviewItem: ReviewItem) {
//		averageCalories = reviewItem.getAverageCaloriesOfScore(scoreType: "high")
		caloriesVSsleep = [
			CaloriesData(averageCalories: reviewItem.getAverageCaloriesOfScore(scoreType: "high"), condition: "Slept Well"), CaloriesData(averageCalories: reviewItem.getAverageCaloriesOfScore(scoreType: "low"), condition: "Not Well")]
	}
	
	
//	@available(iOS 16.0, *)
	var body: some View {
		if #available(iOS 16.0, *) {
			Chart {
				ForEach(self.caloriesVSsleep) { shape in
					BarMark (
						x: .value("Share type", shape.averageCalories),
						y: .value("total count", shape.condition)
					)
				}
			}
		} else {
			Text("Upgrade to ios version 16.0 or higher")
		}
	}
}


//@available(iOS 16.0, *)
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(reviewItem: ReviewItem())
    }
}
