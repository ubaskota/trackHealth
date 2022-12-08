//
//  SleepRecordView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/29/22.
//

import SwiftUI

struct SleepRecordView: View {
	@ObservedObject var audioRecorder: AudioRecorder
	@State private var recordCount = 0	//0 means user hasn't recorded after launching the app, 1 means user is recording, 2 means user recorded and recently stopped
	@State private var showPopover = false
	@State private var displaySurveyView = false
	
	var body: some View {
			ZStack {
				VStack {
					NavigationLink {
						SleepResultView()
					} label: {
						Spacer()
						VStack {
							Image("graphSmallImg")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 100, height: 70)
								.clipped()
								.foregroundColor(.green)
//								.padding([.bottom, .trailing])
							VStack {
								Text("Records")
									.foregroundColor(.white)
							}
							.padding(.vertical)
							.frame(maxWidth: 100)
							.background(.green)
						}
						.clipShape(RoundedRectangle(cornerRadius: 5))
						.overlay(RoundedRectangle(cornerRadius: 5)
							.stroke(.lightBackground))
						.background(.darkBackground)
					}
					Text("Sleep recorder records your sleep and presents you with a sleep graph later.")
						.font(.headline)
						.foregroundColor(.green)
						.frame(width: 350, height: 200)
						.background(.lightBackground)
						.padding([.top, .trailing])
					if audioRecorder.recording == false {
						Button(action: {self.audioRecorder.startRecording(); recordCount+=1; displaySurveyView = true}) {
							Image(systemName: "circle.fill")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 150, height: 150)
								.clipped()
								.foregroundColor(.red)
						}
					}
					else {
						Button(action: {self.audioRecorder.stopRecording(); recordCount+=1}) {
							Image(systemName: "stop.fill")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 150, height: 150)
								.clipped()
								.foregroundColor(.red)
						}
					}
					VStack {
						switch recordCount {
						case 1:
							SleepRecordTopView(recordMessage: "Recording has started! Recording.......")
						case 2:
							NavigationLink(destination: SleepRecordSurveyView(recordMessage: "You've stopped your recording", survey: 1, audioRecorder: self.audioRecorder, showAlert: false), isActive: self.$displaySurveyView) { EmptyView() }
						default:
							SleepRecordTopView(recordMessage: "Recording isn't started. Press the red button to start.")
						}
					}
				}
			}
			.background(.darkBackground)
	}
}


struct SleepRecordTopView: View {
	var recordMessage: String
	
	var body: some View {
		VStack {
			Text(recordMessage)
			.font(.headline)
			.foregroundColor(.green)
			.frame(width: 350, height: 200)
			.background(.lightBackground)
			.padding([.top, .trailing])
			
		}
	}
}


struct SleepRecordView_Previews: PreviewProvider {
    static var previews: some View {
		SleepRecordView(audioRecorder: AudioRecorder())
    }
}
