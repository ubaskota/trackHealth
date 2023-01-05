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

	var caloriesVSsleep: [CaloriesData]
	var physicalVSsleep: [PhysicalData]
	
	let markColors: [LinearGradient] = [
		LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing),
		LinearGradient(colors: [.red, .pink,], startPoint: .leading, endPoint: .trailing)]
	
	init(reviewItem: ReviewItem) {
//		averageCalories = reviewItem.getAverageCaloriesOfScore(scoreType: "high")
		caloriesVSsleep = [
			CaloriesData(averageCalories: reviewItem.getAverageCaloriesOfScore(scoreType: "high"), condition: "Slept Well"),
			CaloriesData(averageCalories: reviewItem.getAverageCaloriesOfScore(scoreType: "low"), condition: "Didn't sleep Well")]
		
		physicalVSsleep = [
			PhysicalData(averageMinutes: reviewItem.getAverageWorkOutTimeOfScore(scoreType: "high"), condition: "Slept Well"),
			PhysicalData(averageMinutes: reviewItem.getAverageWorkOutTimeOfScore(scoreType: "low"), condition: "Didn't sleep Well")]
	}
	
	
//	@available(iOS 16.0, *)
	var body: some View {
		VStack {
			Text("Average so far")
				.underline()

			Text("Physical activities")
				.font(.largeTitle)
			if #available(iOS 16.0, *) {
				Chart {
	//				ForEach(self.caloriesVSsleep) { shape in
	//					BarMark (
	//						x: .value("Share type", shape.averageCalories),
	//						y: .value("total count", shape.condition)
	//					)
	//				}
					
					ForEach(self.physicalVSsleep) { shape in
						BarMark (
							x: .value("total count", shape.condition),
							y : .value("Share type", shape.averageMinutes)
						)
						.foregroundStyle(by: .value("Day", shape.condition))
						.annotation(position: .top) {
							Text("\(shape.averageMinutes) minutes")
								.foregroundColor(.indigo)
						}
					}
				}
				.chartForegroundStyleScale(range: markColors)
				.frame(height: 220)
			}
			else {
				Text("Upgrade to ios version 16.0 or higher")
			}
			
			
			VStack {
				Text("Calorie Intake")
					.font(.largeTitle)
				if #available(iOS 16.0, *) {
					Chart {
						ForEach(self.caloriesVSsleep) { shape in
							BarMark (
								x: .value("total count", shape.condition),
								y: .value("Share type", shape.averageCalories)
							)
							.foregroundStyle(by: .value("Day", shape.condition))
							.annotation(position: .top) {
								Text("\(shape.averageCalories) calories")
									.foregroundColor(.indigo)
							}
						}
					}
					.chartForegroundStyleScale(range: markColors)
					.frame(height: 220)
				} else {
					Text("Upgrade to ios version 16.0 or higher")
				}
			}
		}
	}
}


//@available(iOS 16.0, *)
struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(reviewItem: ReviewItem())
    }
}
