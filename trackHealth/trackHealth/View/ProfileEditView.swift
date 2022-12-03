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
	
	@Environment(\.dismiss) var dismiss
	
	
	
	let races = ["Asian", "Black", "South Asian", "White", "Hispanic", "American Indian", "Other"]
	
	let conditions = ["Yes", "No"]
	
	let genders = ["Male", "Female", "Other"]
	
	@State private var displayName = ""
	@State private var age = ""
	@State private var race = ""
	@State private var height = ""
	@State private var weight = ""
	@State private var gender = ""
	@State private var preExistingConditions = ""
	@State private var uuid = UUID()
	
	
    var body: some View {
		NavigationView {
			VStack {
				Text("Enter your details")
					.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
					.padding([.top, .bottom])
				Form {
						TextField("displayName", text: $displayName)
						.padding()
	//					.background()
						.cornerRadius(20)
						TextField("Age", text: $age)
						.padding()
	//					.background()
						.cornerRadius(20)
						TextField("Height", text: $height)
						.padding()
	//					.background()
						.cornerRadius(20)
						TextField("Weight", text: $weight)
						.padding()
	//					.background()
						.cornerRadius(20)
					
					
					Section(header: Text("Select your race.")) {
							Picker("Race ", selection: $race) {
								ForEach(races, id: \.self) {
									Text($0)
								}
							}
							.font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(Color.green)
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
//				.navigationTitle("Add you details")
				.toolbar {
					Button("Save") {
	//					let item = ProfileItem(id: UUID(), userName: userName,displayName: displayName, age: age, race: race, height: height, weight: weight, preExistingConditions: preExistingConditions)
	//					profile_details.items.append(item)
		
						// Make it such that previous data of the same user is replaced when hit saved.
						
						// User shouldn't be able to change the username at all
						
						let profile = Profile(context: moc)
						profile.uuid = uuid
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
	}
	
	
	var disableForm: Bool {
		if (checkIfEmpty() == true) && (checkIfNumber(input: age) && checkIfNumber(input: height) && checkIfNumber(input: weight)) {
			return true
		}
		return false
	}
	
	
	func checkIfEmpty() -> Bool {
		if (displayName.isEmpty && age.isEmpty && height.isEmpty && weight.isEmpty) {
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
