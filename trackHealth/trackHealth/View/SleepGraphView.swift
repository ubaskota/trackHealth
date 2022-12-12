//
//  SleepGraphView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/10/22.
//

//import SwiftUI
//import SwiftUICharts
//
//struct SleepGraphView: View {
//	VStack{
//		Text("Hello")
//		LineView(data: , title: "Line Chart", legend: "Loudness of the sound recorded in your sleep form start time to end time, left to right.", valueSpecifier: "Kera")
//			.frame(height: 500)
//	}
//}
//
//struct SleepGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        SleepGraphView()
//    }
//}


import SwiftUICharts
import SwiftUI

struct SleepGraphView: View {
	var sleepFileName: String
	var sleepStartTime: Date
	var sleepStopTime: Date
	@ObservedObject var audioRecorder = AudioRecorder()
	
	var body: some View {

		VStack {
			LineView(data: audioRecorder.getSleepArrayFromCoreData(recordDateTime: sleepFileName), title: "Sleep Chart", legend: "Loudness of the sound recorded in your sleep from \(getDateInHours(for: sleepStartTime)) to \(getDateInHours(for: sleepStopTime)), left to right.")
				.frame(height: 500)
		}
		
//		VStack {
//			Text("Hello")
//			LineView(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1], title: "Line Chart", legend: "Loudness of the sound recorded in your sleep form start time to end time, left to right.", valueSpecifier: "Kera")
//				.frame(height: 500)
//		}
	}
}


struct SleepGraphView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

