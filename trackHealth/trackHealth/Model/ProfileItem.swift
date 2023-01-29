//
//  ProfileItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/14/22.
//

import Foundation


class ProfileItem: NSObject, ObservableObject {
	
	let coreDM: DataController = DataController.shared
	
	override init() {
		super.init()
	}
	
	
	func saveProfileToCoredata(displayName: String, age: String, race: String, height: String, weight: String, preExistingConditions: String, gender: String) {
		coreDM.saveProfileDataToCoreData(displayName: displayName, age: age, race: race, height: height, weight: weight, preExistingConditions: preExistingConditions, gender: gender)
	}
	
	
	func getProfileFromCoreData() -> [Profile] {
		return coreDM.getProfileDataFromCoreData()
	}
	
	
	func getProfileDetails(requestType: String) -> String {
		
		var profileDetail: [Profile] = getProfileFromCoreData()
		
		for item in profileDetail {
			if requestType == "name" {
				return item.displayName ?? "NA"
			}
			else if requestType == "age" {
				return String(item.age)
			}
			else if requestType == "height" {
				return String(item.height)
			}
			else if requestType == "weight" {
				return String(item.weight)
			}
			else if requestType == "race" {
				return item.race!
			}
			else if requestType == "gender" {
				return item.gender ?? "NA"
			}
			else if requestType == "knownIssues" {
				if item.preExistingConditions == true {
					return "Yes"
				}
				else {
					return "No"
				}
			}
		}
		return "NA"
	}
}
