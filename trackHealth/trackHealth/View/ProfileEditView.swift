//
//  ProfileView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/13/22.
//

import SwiftUI
import Foundation

struct ProfileEditView: View {
	
	@Environment(\.dismiss) var dismiss
	var profileItem: ProfileItem
	
	let races = ["Select", "Other", "Asian", "Black", "South Asian", "White", "Hispanic", "American Indian"]
	let conditions = ["Select", "No", "Yes"]
	let genders = ["Select", "Male", "Female", "Other"]
	
	@State private var displayName = ""
	@State private var age = ""
	@State private var race = ""
	@State private var height = ""
	@State private var weight = ""
	@State private var gender = ""
	@State private var preExistingConditions = ""
	@State private var preExCondition = true
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
							Picker("Ethnicity ", selection: $race) {
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
//						.pickerStyle(WheelPickerStyle())
						.font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(Color.green)
					}
					
					Section(header: Text("Pre-existing sleep issue")) {
						Picker("Condition", selection: $preExistingConditions) {
							ForEach(conditions, id: \.self) {
								Text($0)
							}
						}
//						.pickerStyle(WheelPickerStyle())
						.font(.system(size: 20, weight: .bold, design: .default)).foregroundColor(Color.green)
					}
					
					// For saved information
					
					Section(header: Text("Saved User Information")) {
						Text("Display Name : \(profileItem.getProfileDetails(requestType: "name"))")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
						Text("Age : \(profileItem.getProfileDetails(requestType: "age")) years")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
						Text("Height : \(profileItem.getProfileDetails(requestType: "height")) feet")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
						Text("Weight : \(profileItem.getProfileDetails(requestType: "weight"))")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
						Text("Ethnicity: \(profileItem.getProfileDetails(requestType: "race"))")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
						Text("gender : \(profileItem.getProfileDetails(requestType: "gender"))")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
						Text("Any known sleep issue/s : \(profileItem.getProfileDetails(requestType: "knownIssues"))")
							.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
							.padding([.top, .bottom])
					}
					
					VStack(alignment: .trailing) {
						Text("Contact us: tracksleephealth@gmail.com")
							.fontWeight(.bold)
							.font(.system(size: 16))
							.foregroundColor(.green)
					}
				}
				.toolbar {
					Button("Save") {
						preExCondition = convertToBool(statement: preExistingConditions)
						profileItem.saveProfileToCoredata(displayName: displayName, age: age, race: race, height: height, weight: weight, preExistingConditions: preExistingConditions, gender: gender)
						dismiss()
					}
					.foregroundColor(disableForm ? .white : .green)
					.disabled(disableForm)
				}
			}
		}
	}
	
	func convertToBool(statement: String) -> Bool {
		if statement == "Yes" {
			return true
		}
		return false
	}
	
	
	var disableForm: Bool {
		if (checkIfEmpty() || !checkIfNumber(input: age) || !checkIfNumber(input: height) || !checkIfNumber(input: weight) || race == "Select" || gender == "Select" || preExistingConditions == "Select") {
			return true
		}
		return false
	}
	
	
	func checkIfEmpty() -> Bool {
		if (displayName.isEmpty || age.isEmpty || height.isEmpty || weight.isEmpty || race.isEmpty || gender.isEmpty || preExistingConditions.isEmpty) {
			return true
		}
		else {
			return false
			
		}
	}
	
	
	func checkIfNumber(input: String) -> Bool {
		let characters = CharacterSet.decimalDigits
		print("This is the result for : \(input) is \(CharacterSet(charactersIn: input).isSubset(of: characters))")
		return CharacterSet(charactersIn: input).isSubset(of: characters)
	}
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {

		ProfileEditView(profileItem: ProfileItem())
    }
}
