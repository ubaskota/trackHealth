//
//  TestView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/3/22.
//

import SwiftUI

struct TestView: View {
	@State private var foodOne: String = ""
	@State private var distanceOne: Int16 = 0
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		NavigationView {
			Form {
				TextField("Food One", text: $foodOne)
				TextField("Food One", value: $distanceOne, formatter: NumberFormatter())
			}
			.toolbar {
				Button("ADD") {
					print("This is the food: \(foodOne), and this is the distance : \(distanceOne)")
					dismiss()
				}
				.font(.system(size: 20, weight: .bold, design: .default))
				.disabled(foodOne.isEmpty || foodOne.count < 3 || distanceOne <= 0)
			}
		}
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
