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


class AudioRecorder: NSObject, ObservableObject {
	
	override init() {
		super.init()
		fetchRecordings()
	}
	
	let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
	
	var audioRecorder: AVAudioRecorder!
	var recordings = [Recording]()
	var recordingsForDisaply = [DisplayRecording]()
	
	var sleepStartTime: Date!
	var sleepStopTime: Date!
	var sleepFileName: String!
	var soundDb: [Float]!
	var survey: Bool!
	var uuid: UUID!
	var sleepScore: Float!
	
	
	var recording = false {
		didSet {
			objectWillChange.send(self)
		}
	}
	
	
	func startRecording() {
		
		deleteAllPreviousRecordings()  // Need to delete previous recordings for clearup space as we not need the files later
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
	
	
	func deleteAllPreviousRecordings() {
		
		let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		do {
			let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
																	   includingPropertiesForKeys: nil,
																	   options: .skipsHiddenFiles)
			for fileURL in fileURLs where fileURL.pathExtension == "m4a" {
				try FileManager.default.removeItem(at: fileURL)
			}
		} catch  { print("Error deleteing file : ", error) }
	}
	
	
	func stopRecording() {
		audioRecorder.stop()
		recording = false
		fetchRecordings()
	}
	
	
	func fetchRecordings() {
		recordings.removeAll()
		
		let fileManager = FileManager.default
		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
		for audio in directoryContents {
			let creationDateTime = getCreationDate(for: audio)
			let recording = Recording(fileURL: audio, createdAt: creationDateTime)
			let displayRecording = DisplayRecording(displayCreationDate: getDisplayDate(for: creationDateTime), createdAt: creationDateTime)
			recordings.append(recording)
			recordingsForDisaply.append(displayRecording)
		}
		
		recordings.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedAscending})
		recordingsForDisaply.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedAscending})
		objectWillChange.send(self)
	}
	
	
	func saveToCoreData(survey: Int8) -> String {
		print("This is the survey : ", survey)
		return "Hello"
	}
}

