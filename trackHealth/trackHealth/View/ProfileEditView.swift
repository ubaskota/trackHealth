//
//  ProfileView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/13/22.
//

import SwiftUI
import Foundation

struct ProfileEditView: View {
	
	@Environment(\.managedObjectContext) var moc
	
//	@ObservedObject var profile_details: ProfileDetails
	@Environment(\.dismiss) var dismiss
	
	let races = ["Asian", "Black", "South Asian", "White", "Hispanic", "American Indian", "Other"]
//	@State private var raceIndex = 0
	
	let conditions = ["Yes", "No"]
//	@State private var conditionIndex = 0
	
	let genders = ["Male", "Female", "Other"]
	
	@State private var userName = ""
	@State private var displayName = ""
	@State private var age = ""
	@State private var race = ""
	@State private var height = ""
	@State private var weight = ""
	@State private var gender = ""
	@State private var preExistingConditions = ""
	
//	Group {
//		Button(action: {
//			Text("Action")
//		}) {
//			Image(systemName: "info.circle")
//				.foregroundColor(.accentColor)
//		}
//	}
//
	
    var body: some View {
		NavigationView {
			Form {
				Section(header: Text("Enter your details")) {
					TextField("UserName", text: $userName)
					TextField("DisplayName", text: $displayName)
					TextField("Age", text: $age)
					TextField("Height", text: $height)
					TextField("Weight", text: $weight)
				}
				
				Section(header: Text("Select your race.")) {
						Picker("Race ", selection: $race) {
							ForEach(races, id: \.self) {
								Text($0)
							}
						}
						.clipped()
						.frame(width: 250, height: 20)
				}
				
				Section(header: Text("Select your gender.")) {
					Picker("Gender ", selection: $gender) {
						ForEach(genders, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(WheelPickerStyle())
					.clipped()
					.frame(width: 100, height: 40)
				}
				
				Section(header: Text("Pre-Existing Condition")) {
					Picker("Sample", selection: $preExistingConditions) {
						ForEach(conditions, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(WheelPickerStyle())
					.clipped()
					.frame(width: 100, height: 40)
				}
			}
			.navigationTitle("Add you details")
			.toolbar {
				Button("Save") {
//					let item = ProfileItem(id: UUID(), userName: userName,displayName: displayName, age: age, race: race, height: height, weight: weight, preExistingConditions: preExistingConditions)
//					profile_details.items.append(item)
	
					// Make it such that previous data of the same user is replaced when hit saved.
					
					// User shouldn't be able to change the username at all 
					
					let profile = Profile(context: moc)
					profile.userName = userName
					profile.displayName = displayName
					profile.age = Float(age) ?? 0.0
					profile.race = race
					profile.height = Float(height) ?? 0.0
					profile.weight = Float(weight) ?? 0.0
//					profile.preExistingConditions = true
					profile.preExistingConditions = preExistingConditions == "Yes" ? true : false

					
					
//					try? moc.save()
					do {
						try moc.save()
							print("Successfully saved..")
					} catch {
							print("Unexpected error: \(error).")
//						let nserror = error as NSError
//						fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
						}
					dismiss()
					
				}
				.disabled(disableForm)
			}
		}
	}
	
	var disableForm: Bool {
		if (checkIfEmpty() == true) && (checkIfNumber(input: age) && checkIfNumber(input: height) && checkIfNumber(input: weight)) {
			return true
		}
		return false
	}
	
	func checkIfEmpty() -> Bool {
		if (userName.isEmpty && displayName.isEmpty && age.isEmpty && height.isEmpty && weight.isEmpty) {
			return true
		}
		else {
			return false
			
		}
	}
	
	
	func checkIfNumber(input: String) -> Bool {
		let characters = CharacterSet.decimalDigits
		return CharacterSet(charactersIn: input).isSubset(of: characters)
	}
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
//		ProfileEditView(profile_details: ProfileDetails())
		ProfileEditView()
    }
}
