//
//  RecordHelper.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/26/22.
//

import Foundation


func getCreationDate(for file: URL) -> Date {
	
	if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
		let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
		return creationDate
	}else {
		return Date()
	}
}


func getDisplayDate(for creationDate: Date) -> String {
	let newCreationDate = creationDate.toString(dateFormat: "EEEE, MMM d, yyyy h:mm a")
	print("This is creation date : ", newCreationDate)
	return newCreationDate
}

func getDateInHours(for givenDateTime: Date) -> String {
	let newCreationDate = givenDateTime.toString(dateFormat: "h:mm a")
	print("This is creation date : ", newCreationDate)
	return newCreationDate
}

