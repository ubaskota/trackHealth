//
//  Color-Theme.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/25/22.
//

import Foundation
import SwiftUI


extension ShapeStyle where Self == Color {
	static var darkBackground: Color {
		Color(red: 0.1, green: 0.1, blue: 0.2)
	}
	
	static var lightBackground: Color {
		Color(red: 0.2, green: 0.2, blue: 0.3)
	}
	
	static var blockBackground: Color {
		Color(red: 0.5, green: 0.3, blue: 0.2)
	}
}
