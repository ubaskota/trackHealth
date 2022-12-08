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
	
//	@Environment(\.managedObjectContext) var moc
//	var moc = PersistentController.shared.container.viewContext
	var moc = DataController.init().container.viewContext
	
	override init() {
		super.init()
//		fetchRecordings()
	}
	
	let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
	
	var audioRecorder: AVAudioRecorder!
	var recordings = [Recording]()
	var recordingsForDisaply = [DisplayRecording]()
	
	@Published var sleepStartTime: Date!
	@Published var sleepStopTime: Date!
	@Published var sleepFileName: String!
	@Published var soundDb = [Float]()
//	var survey: Int16!
	@Published var uuid: UUID!
	@Published var sleepScore: Float!
	
	
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
		let startDateTime = Date()
		self.sleepStartTime = startDateTime
		let audioFilename = documentPath.appendingPathComponent("\(startDateTime.toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
		let settings = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 12000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
		do {
			audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
			audioRecorder.record()
			audioRecorder.isMeteringEnabled = true
			recording = true
			
			Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [self] timer in
				self.audioRecorder.updateMeters()
				let db = audioRecorder.averagePower(forChannel: 0)
				self.soundDb.append(db)
				print(self.soundDb)
			}
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
		print(self.soundDb)
		self.sleepStopTime = Date()
//		fetchRecordings()
	}
	
	
	func getfileName() -> String{
		
		let fileManager = FileManager.default
		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
		//		for audio in directoryContents {
		let creationDateTime = getCreationDate(for: directoryContents[0])
		//			let recording = Recording(fileURL: audio, createdAt: creationDateTime)
		let displayRecording = DisplayRecording(displayCreationDate: getDisplayDate(for: creationDateTime), createdAt: creationDateTime)
		recordingsForDisaply.append(displayRecording)
		return displayRecording.displayCreationDate
	}
	
	
	func saveToCoreData(survey: Int16){
		
		let sleep = Sleep(context: moc)
		sleep.uuid = UUID()
		sleep.sleepFileName = getfileName()
//		sleep.sleepScore = calculateSleepScore(survey: survey, soundDB: soundDb)
		sleep.sleepScore = calculateSleepScore(survey: survey)
		sleep.sleepStartTime = sleepStartTime
		sleep.sleepStopTime = sleepStopTime
		do {
			try sleep.soundDb = try NSKeyedArchiver.archivedData(withRootObject: self.soundDb ?? [0.0], requiringSecureCoding: true)
			print("Successfully saved..")
		}
		catch {
			print("Unexpected error: \(error).")
		}
		sleep.survey = survey
		
		do {
			try moc.save()
			print("Sucessfully saved sleeep data")
		} catch {
			print("Unexpected error saving sleep data: \(error).")
		}
	}
	
	
//	func calculateSleepScore(survey: Int16, soundDB: [Float]) -> Float {
	func calculateSleepScore(survey: Int16) -> Float {
//		let filteredDb = sleepDBFilter(soundDB: soundDB)
		let filteredDb = sleepDBFilter()
		print(filteredDb)
		let filteredDBCount = filteredDb.count
		var totalDB = filteredDb.reduce(0, +) * -1
		if filteredDBCount == 0 {
			totalDB = 0
		}
		let finalSleepScore = (totalDB / Float(filteredDBCount)) + Float(survey * 20)
		return finalSleepScore
	}
	
	
//	func sleepDBFilter(soundDB: [Float]) -> [Float] {
	func sleepDBFilter() -> [Float] {
		var filteredSleepDB = [Float]()
		
		for db in self.soundDb {
			if db > -35 {
				filteredSleepDB.append(db)
			}
//			if db < 0 {
//				filteredSleepDB.append(db)
//			}
		}
		print(self.soundDb)
		return filteredSleepDB
	}
	
	
//	func unarchiveSleepDB() -> [String] {
//		let sleep = Sleep(context: moc)
//
//		if let sleep = sleep.soundDb {
//		  do {
//			if let sleepDBArray = try NSKeyedUnarchiver.unarchivedObject(ofClass: NSArray.self, from: sleep) as? [String] {
//			  dump(sleepDBArray)
//				return sleepDBArray
//			}
//		  } catch {
//			print("could not unarchive array: \(error)")
//		  }
//		}
//		return []
//	}
	
	
//	func fetchRecordings() {
//		recordings.removeAll()
//
//		let fileManager = FileManager.default
//		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//		let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
//		for audio in directoryContents {
//			let creationDateTime = getCreationDate(for: audio)
//			let recording = Recording(fileURL: audio, createdAt: creationDateTime)
//			let displayRecording = DisplayRecording(displayCreationDate: getDisplayDate(for: creationDateTime), createdAt: creationDateTime)
//			recordings.append(recording)
//			recordingsForDisaply.append(displayRecording)
//		}
//
//		recordings.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedAscending})
//		recordingsForDisaply.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedAscending})
//		objectWillChange.send(self)
//	}
//
	
	
}

