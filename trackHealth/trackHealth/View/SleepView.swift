//
//  SleepView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 6/2/22.
//

import SwiftUI

struct SleepView: View {
	let viewOptions: [String] = ["sleep_record", "sleep_history"]
	let imageOptions: [String: String] = ["sleep_record": "microphoneImg", "sleep_history": "graphImg"]
	let textOptions: [String: String] = ["sleep_record":"Sleep Recorder", "sleep_history": "Results"]
	
	var body: some View {
		ScrollView {
				ForEach(viewOptions, id: \.self) { topic in
					NavigationLink {
						switch topic {
						case "sleep_record":
							SleepRecordView(audioRecorder: AudioRecorder())
						default:
							SleepResultView()
//							ReviewView()
						}
					} label: {
						VStack {
							Image(imageOptions[topic]!)
								.resizable()
								.scaledToFit()
								.frame(width: 200, height: 200)
								.padding()
							VStack {
								Text(textOptions[topic]!)
								.font(.headline)
								.foregroundColor(.green)
						}
								.padding(.vertical)
								.frame(maxWidth: 100)
								.background(.darkBackground)
							}
						.clipShape(RoundedRectangle(cornerRadius: 10))
						.overlay(RoundedRectangle(cornerRadius: 10)
							.stroke(.lightBackground))
						.background(.darkBackground)
					}
				}
				.padding([.horizontal, .bottom])
				.background(.white)
			}
	}
}


struct SleepView_Previews: PreviewProvider {
    static var previews: some View {
        SleepView()
    }
}
