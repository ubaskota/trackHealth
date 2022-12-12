//
//  MealDetails.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 6/1/22.
//

import Foundation
//
//class MealDetails: ObservableObject {
//	@Published var items = [MealItem]() {
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
//			if let decodedItems = try? JSONDecoder().decode([MealItem].self, from: savedItems) {
//				items = decodedItems
//				return
//			}
//		}
//		items = []
//	}
//}
