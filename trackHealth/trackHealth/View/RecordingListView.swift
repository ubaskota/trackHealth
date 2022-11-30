//
//  RecordingListView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/25/22.
//

import SwiftUI

struct RecordingListView: View {
	@ObservedObject var audioRecorder: AudioRecorder
	
    var body: some View {
		List {
//			ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
//				RecordingRowView(audioURL: recording.fileURL)
//			}
			ForEach(audioRecorder.recordingsForDisaply, id: \.displayCreationDate) { recording in
				Text(recording.displayCreationDate)
				Spacer()
			}
		}
	}
}


//struct RecordingRowView: View {
//	var audioURL: URL
//
//	var body: some View {
//		HStack {
//			Text("\(audioURL.lastPathComponent)")
//			Spacer()
//		}
//	}
//}


struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView(audioRecorder: AudioRecorder())
    }
}
