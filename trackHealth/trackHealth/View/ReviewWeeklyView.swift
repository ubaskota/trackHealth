//
//  ReviewWeeklyView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/17/22.
//

import SwiftUI
import Charts


struct CaloriesWeeklyData: Identifiable {
	var id = UUID()
	var calories: Int32
	var condition: String
	var displayDate: String
}


struct PhysicalWeeklyData: Identifiable {
	var id = UUID()
	var physicalMins: Int32
	var condition: String
	var displayDate: String
}


struct ReviewWeeklyView: View {
	
	var caloriesVSsleep: [CaloriesWeeklyData]
	var physicalVSsleep: [PhysicalWeeklyData]
	
	let markColors: [LinearGradient] = [
		LinearGradient(colors: [.red, .pink,], startPoint: .leading, endPoint: .trailing),
		LinearGradient(colors: [.blue, .green], startPoint: .leading, endPoint: .trailing)]
	
	init(reviewItem: ReviewItem) {
		let weeklyCaloriesAndScore = reviewItem.getWeeklyCaloriesAndScore()
		let weeklyPhysicalAndScore = reviewItem.getWeeklyPhysicalAndScore()
		
		let listLengthCal = weeklyCaloriesAndScore.count
		caloriesVSsleep = (0..<listLengthCal).map({CaloriesWeeklyData(calories: weeklyCaloriesAndScore[$0].calorie, condition: weeklyCaloriesAndScore[$0].score == "high" ? "Slept well" : "Didn't sleep well", displayDate: weeklyCaloriesAndScore[$0].date)})
		
		let listLengthPhl = weeklyPhysicalAndScore.count
		physicalVSsleep =  (0..<listLengthPhl).map({PhysicalWeeklyData(physicalMins: weeklyPhysicalAndScore[$0].workOutMins, condition: weeklyPhysicalAndScore[$0].score == "high" ? "Slept well" : "Didn't sleep well", displayDate: weeklyPhysicalAndScore[$0].date)})
	}
	
    var body: some View {
		VStack {
			
			VStack {
				Text("Physical activities")
					.font(.largeTitle)
				Text("Minutes")
				if #available(iOS 16.0, *) {
					Chart {
						ForEach(self.physicalVSsleep) { shape in
							BarMark (
								x: .value("total count", shape.displayDate),
								y : .value("Share type", shape.physicalMins)
							)
							.foregroundStyle(by: .value("Day", shape.condition))
							.annotation(position: .top) {
								Text("\(shape.physicalMins)")
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
				
				Text("Calorie Intake")
					.font(.largeTitle)
				Text("Calories")
				if #available(iOS 16.0, *) {
					Chart {
						ForEach(self.caloriesVSsleep) { shape in
							BarMark (
								x: .value("total count", shape.displayDate),
								y: .value("Share type", shape.calories)
							)
							.foregroundStyle(by: .value("Day", shape.condition))
							.annotation(position: .top) {
								Text("\(shape.calories)")
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

struct ReviewWeeklyView_Previews: PreviewProvider {
    static var previews: some View {
		ReviewWeeklyView(reviewItem: ReviewItem())
    }
}
