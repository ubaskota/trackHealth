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
        Text("Hello, World!")
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingListView(audioRecorder: AudioRecorder())
    }
}
