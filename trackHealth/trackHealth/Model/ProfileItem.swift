//
//  ProfileItem.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/14/22.
//

import Foundation


struct ProfileItem: Identifiable, Codable {

	var id = UUID()
	let userName: String?
	let displayName: String?
	let age: String?
	let race: String?
	let height: String?
	let weight: String?
	let preExistingConditions: String
}
