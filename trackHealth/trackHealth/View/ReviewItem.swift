//
//  ReviewItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/12/22.
//

import Foundation

class ReviewItem: NSObject, ObservableObject {
	
	override init() {
		super.init()
	}
	
	func getHighSleepScoreDates() -> [Date]{
		return []
	}
	
	
	func getLowSleepScoreDates() -> [Date] {
		return []
	}
	
	
	func getAllCaloriesFromDates(allDates: [Date]) -> [Int32] {
		return []
	}
	
	
	//In the future we need to be able to get the data for all workout types
	func getAllWorkOutMinutesFromDates(allDates: [Date]) -> [Int32] {
		return []
	}
}
