//
//  AudioRecorder.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/25/22.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation


class AudioRecorder: ObservableObject {
	
	let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
	
	var audioRecorder: AVAudioRecorder!
	var recordings = [Recording]()
	
	var recording = false {
		didSet {
			objectWillChange.send(self)
		}
	}
	
	
	func startRecording() {
		let recordingSession = AVAudioSession.sharedInstance()
		
		do {
			try recordingSession.setCategory(.playAndRecord, mode: .default)
			try recordingSession.setActive(true)
			
		} catch {
			print("Failed to setup recording session")
		}
		
		let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
		
		
		let settings = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 12000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
		
		
		do {
			audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
			audioRecorder.record()
			recording = true
		} catch {
			print("Could not start recording")
		}
	}
	
	
	func stopRecording() {
		audioRecorder.stop()
		recording = false
	}
	
	
	func fetchRecordings() {
		recordings.removeAll()
		
		let fileManager = FileManager.default
		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
		for audio in directoryContents {
			
		}
	}
}