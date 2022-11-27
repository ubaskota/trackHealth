//
//  SleepView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 6/2/22.
//

import SwiftUI

struct SleepView: View {
	@ObservedObject var audioRecorder: AudioRecorder
	
	
    var body: some View {
		NavigationView {
			VStack {
				
				RecordingListView(audioRecorder: AudioRecorder())
				
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


struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        SleepView(audioRecorder: AudioRecorder())
    }
}
