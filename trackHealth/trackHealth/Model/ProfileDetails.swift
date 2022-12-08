//
//  ProfileDetails.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/14/22.
//

//import Foundation
//
//class ProfileDetails: ObservableObject {
//	@Published var items = [ProfileItem]() {
//		didSet {
//			let encoder = JSONEncoder()
//
//			if let encoded = try? encoder.encode(items) {
//				UserDefaults.standard.set(encoded, forKey: "Items")
//			}
//		}
//	}
//	init() {
//		if let savedItems = UserDefaults.standard.data(forKey: "Items") {
//			if let decodedItems = try? JSONDecoder().decode([ProfileItem].self, from: savedItems) {
//				items = decodedItems
//				return
//			}
//		}
//		items = []
//	}
//}
