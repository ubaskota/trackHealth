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
		ZStack {
			VStack {
				Text("Recordings")
					.foregroundColor(.indigo)
					.font(.system(size: 40, weight: .bold, design: .default))
				List(audioRecorder.getSleepFromCoreData()) { sInfo in
					NavigationLink {
		//				Text(String(sInfo.sleepFileName!))
						SleepGraphView(sleepScore: Int(sInfo.sleepScore), sleepFileName: sInfo.sleepFileName!, sleepStartTime: sInfo.sleepStartTime!, sleepStopTime: sInfo.sleepStopTime!, audioRecorder: AudioRecorder())
					} label: {
						SleepResultRowView(sleepScore: Int(sInfo.sleepScore), fileName: sInfo.sleepFileName!)
					}
				}
			}
		}
	}
}


struct SleepResultView_Previews: PreviewProvider {
	static var previews: some View {
		SleepResultView()
	}
}
