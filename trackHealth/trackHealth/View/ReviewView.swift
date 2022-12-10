//
//  ReviewView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//

import SwiftUI

struct ReviewView: View {
	//	@Environment(\.managedObjectContext) var moc
	//	@FetchRequest(sortDescriptors: []) var profileInfo: FetchedResults<Profile>
	//	@FetchRequest(sortDescriptors: []) var sleepInfo: FetchedResults<Sleep>
	//	@FetchRequest(entity: Meal.entity(), sortDescriptors: []) var mealInfo: FetchedResults<Meal>
	@ObservedObject var mealItem: MealItem
	
	var body: some View {
		Text("Lamo Kera")
		//		List(mealInfo) { mInfo in
		//			Text(mInfo.foodOne!)
		//		}
		
		//		let sleepDB = audioRecorder.unarchiveSleepDB()
		
		List(mealItem.getMealFromCoreData()){ pInfo in
			Text(String(pInfo.foodOne!))
			Text(String(pInfo.totalCalories))
			
			//			ForEach(profileInfo) { pInfo in
			//				VStack {
			//					Text(pInfo.race ?? "Unknown")
			//						.font(.headline)
			//					Text("\(pInfo.weight)")
			//						.foregroundColor(.secondary)
			//				}
			//			}
		}
		//		Text("This is sleepdb: \(sleepDB)")
	}
}
	

//	func unarchiveSleepDB() -> [String] {
//		let sleep = Sleep(context: moc)
//
//		if let sleep = sleep.soundDb {
//		  do {
//			if let sleepDBArray = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: sleep) as? [String] {
//			  dump(sleepDBArray)
//				return sleepDBArray
//			}
//		  } catch {
//			print("could not unarchive array: \(error)")
//		  }
//		}
//		return []
//	}

//}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(mealItem: MealItem())
    }
}
