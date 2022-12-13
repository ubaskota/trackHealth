//
//  workOutItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/11/22.
//

import Foundation


class WorkOutItem:  NSObject, ObservableObject {
	
	let coreDM: DataController = DataController.shared
	
	override init() {
		super.init()
	}
	
	
	func saveWorkOutToCoredata(weightsTotal: Int32, runWalkTotal: Float, sportsTotal: Int32) {
		coreDM.saveWorkOutDataToCoreData(weightsTotal: weightsTotal, runWalkTotal: runWalkTotal, sportsTotal: sportsTotal)
	}
	
	
	func getWorkOutFromCoreData() -> [Work] {
		return coreDM.getWorkOutDataFromCoreData()
	}
	
	
	func getAverageWeightsTime() -> Int32 {

		var averageWorkoutTime: Int32 = 0
		var count: Int32 = 0
		let workOutInfo = getWorkOutFromCoreData()
		for work in workOutInfo {
			averageWorkoutTime += work.weightsTotal
			count += 1
		}
		if count == 0{
			return 0
		}
		averageWorkoutTime = averageWorkoutTime/count
		return averageWorkoutTime
	}
	
	
	func getAverageDistance() -> Float {
		
		var averageDistance: Float = 0
		var count: Float = 0
		let workOutInfo = getWorkOutFromCoreData()
		for work in workOutInfo {
			averageDistance += work.runWalkTotal
			count += 1
		}
		if count == 0{
			return 0
		}
		
		averageDistance = averageDistance/Float(count)
		return averageDistance
	}
	
	
	func getAverageSportsTime() -> Int32 {

		var averageWorkoutTime: Int32 = 0
		var count: Int32 = 0
		let workOutInfo = getWorkOutFromCoreData()
		for work in workOutInfo {
			averageWorkoutTime += work.sportsTotal
			count += 1
		}
		if count == 0{
			return 0
		}
		averageWorkoutTime = averageWorkoutTime/count
		return averageWorkoutTime
	}
}
