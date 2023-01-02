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
	let coreDM: DataController = DataController.shared
	
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
	@Published var soundDb = [Double]()
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
				var dbToAdd: Float
				// Logic regarding the algorithm explained below this function
				if db > -60 {
					dbToAdd = db * (-1)
					if dbToAdd > 50 {
						dbToAdd = 50
					}
					dbToAdd = (50 - dbToAdd) * 2
					self.soundDb.append(Double(dbToAdd))
					print(self.soundDb)
				}
				if recording == false{
					timer.invalidate()
				}
			}
		} catch {
			print("Could not start recording")
		}
	}
	// Since we calculate Dbfs(Decible sth sth) and it is in negative, we had to figure out a way to solve this. Lowest sound means anything below -50 and highest sound means anything closer to 0. Thus, we convert the numbers to positive. -45 which is a lowest sound becomes +45, which is still a lowest sound but doing so helps us to properly calculate the sleep score later. Subtracting it by 50 makes it easier to represent in the graph. -45(lower sound) has become +45 and, -3(louder sound) has become +3 but in our graph we want the louder sound to be shown higher than the lower sound. Subtracting the dbfs numbers by 50 will help us achive that.
	
	
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
		let creationDateTime = getCreationDate(for: directoryContents[0])
		let displayRecording = DisplayRecording(displayCreationDate: getDisplayDate(for: creationDateTime), createdAt: creationDateTime)
		recordingsForDisaply.append(displayRecording)
		// Delete all previous recordings
		deleteAllPreviousRecordings()
		return displayRecording.displayCreationDate
	}
	
	
	func saveSleepToCoreData(survey: Int16){
		
		sleepFileName = getfileName()
		sleepScore = Float(calculateSleepScore(survey: survey))
		self.soundDb.append(0) // Added this only to make sure that the graph goes from 0 to 100
		self.soundDb.append(100) // Added this only to make sure that the graph goes from 0 to 100
		coreDM.saveSleepDataToCoreData(survey: survey, fileName: sleepFileName, sleepScore: sleepScore, sleepStartTime: sleepStartTime, sleepStopTime: sleepStopTime, soundDb: soundDb)
	}
	
	
	func getSleepFromCoreData() -> [Sleep] {
		return coreDM.getSleepDataFromCoreData()
	}
	
	
	func calculateSleepScore(survey: Int16) -> Double {
		let filteredDb = sleepDBFilter()
//		print(filteredDb)
		var dBCount = filteredDb.count
		let totalDB = filteredDb.reduce(0, +)
		if dBCount == 0 {
			dBCount = 1
		}
		print("This iss the score from db array: \(totalDB/Double(dBCount))")
		let finalSleepScore = (totalDB / Double(dBCount)) + Double(survey * 10)
		return finalSleepScore
	}
	
	
	// In the current db array(after some data manipulation), 80 means the person's sleep at that point was loud and 20 means the person slept well. To further calculate sleepscore, we subtract the current sleep loudness by 100. Person with 20 loudness will get higher points(100-20 = 80) than the person with 80 loudness(100-80 = 20) and we divide the score to make below 50
	func sleepDBFilter() -> [Double] {
		var filteredSleepDB = [Double]()

		for db in self.soundDb {
			let dbForScore = (100 - db)/2
			filteredSleepDB.append(dbForScore)
//			if db < 0 {
//				filteredSleepDB.append(db)
//			}
		}
		print(self.soundDb)
		return filteredSleepDB
	}
	
	
	func getSleepArrayFromCoreData(recordDateTime: String) -> [Double] {
		return coreDM.getSleepDbDataArrayFromCoreData(recordDateTime: recordDateTime)
	}
	
//	func getSleepArrayFromCoreData(recordDateTime: String) -> [String] {
//		print("HELLO")
//		let test = coreDM.getSleepDbDataArrayFromCoreData(recordDateTime: recordDateTime)
//		print("This is a test ", test)
//		return test
//	}
	
	
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

