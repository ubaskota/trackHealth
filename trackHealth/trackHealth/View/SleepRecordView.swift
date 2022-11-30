//
//  SleepRecordView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/29/22.
//

import SwiftUI

struct SleepRecordView: View {
	@ObservedObject var audioRecorder: AudioRecorder
	
	
	var body: some View {
		NavigationView {
			VStack {
//				RecordingListView(audioRecorder: AudioRecorder())
				
				if audioRecorder.recording == false {
					Button(action: {self.audioRecorder.startRecording()}) {
						Image(systemName: "circle.fill")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 100, height: 100)
							.clipped()
							.foregroundColor(.red)
							.padding(.bottom, 40)
					}
				}
				else {
					Button(action: {self.audioRecorder.stopRecording()}) {
						Image(systemName: "stop.fill")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 100, height: 100)
							.clipped()
							.foregroundColor(.red)
							.padding(.bottom, 40)
					}
				}
			}
		}
		.navigationBarTitle("Sleep Recorder")
	}
}


struct SleepRecordView_Previews: PreviewProvider {
    static var previews: some View {
		SleepRecordView(audioRecorder: AudioRecorder())
    }
}
