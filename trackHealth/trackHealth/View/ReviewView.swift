//
//  ReviewView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//

import SwiftUI

struct ReviewView: View {
	@Environment(\.managedObjectContext) var moc
	@FetchRequest(sortDescriptors: []) var profileInfo: FetchedResults<Profile>
		
    var body: some View {
		Text("Lamo Kera")
		List(profileInfo){ pInfo in
			Text(pInfo.race ?? "Geda")
			
//			ForEach(profileInfo) { pInfo in
//				VStack {
//					Text(pInfo.race ?? "Unknown")
//						.font(.headline)
//					Text("\(pInfo.weight)")
//						.foregroundColor(.secondary)
//				}
//			}
		}
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
