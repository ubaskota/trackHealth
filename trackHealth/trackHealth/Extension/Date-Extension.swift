//
//  Date-Extension.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/25/22.
//

import Foundation


extension Date {
	
	func toString(dateFormat format : String) -> String {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}
	
}
