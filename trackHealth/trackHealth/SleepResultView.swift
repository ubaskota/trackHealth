//
//  SleepResultView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/6/22.
//

import SwiftUI

struct SleepResultView: View {
	@ObservedObject var audioRecorder = AudioRecorder()

	var body: some View {
		Text("Hello")
		List(audioRecorder.getSleepFromCoreData()) { sInfo in
			NavigationLink {
//				Text(String(sInfo.sleepFileName!))
				SleepGraphView(sleepFileName: sInfo.sleepFileName!, audioRecorder: AudioRecorder())
			} label: {
				Text(String(sInfo.sleepFileName!))
			}
		}
	}
}


struct SleepResultView_Previews: PreviewProvider {
	static var previews: some View {
		SleepResultView()
	}
}
