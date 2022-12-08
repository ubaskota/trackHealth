//
//  SleepResultView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/6/22.
//

import SwiftUI

struct SleepResultView: View {
//	@Environment(\.managedObjectContext) var moc
	@FetchRequest(entity: Sleep.entity(), sortDescriptors: []) var sleepDetail: FetchedResults<Sleep>

	var body: some View {
		Text("Hello")
		List(sleepDetail) { sInfo in
			Text(String(sInfo.sleepScore))
		}
	}
}


struct SleepResultView_Previews: PreviewProvider {
	static var previews: some View {
		SleepResultView()
	}
}
