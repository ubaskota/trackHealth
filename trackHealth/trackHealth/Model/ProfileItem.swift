//
//  ProfileItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/14/22.
//

import Foundation


class ProfileItem: NSObject, ObservableObject {

//	var id = UUID()
//	let userName: String?
//	let displayName: String?
//	let age: String?
//	let race: String?
//	let height: String?
//	let weight: String?
//	let preExistingConditions: String
	
	let coreDM: DataController = DataController.shared
	
	override init() {
		super.init()
	}
	
	
	func saveProfileToCoredata(displayName: String, age: Int16, race: String, height: Float, weight: Float, preExistingConditions: Bool) {
		coreDM.saveProfileDataToCoreData(displayName: displayName, age: age, race: race, height: height, weight: weight, preExistingConditions: preExistingConditions)
	}
	
	
	func getProfileFromCoreData() -> [Profile] {
		return coreDM.getProfileDataFromCoreData()
	}
}
