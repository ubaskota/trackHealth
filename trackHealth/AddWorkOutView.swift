//
//  AddWorkOutView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/11/22.
//

import SwiftUI

struct AddWorkOutView: View {
	@Environment(\.dismiss) var dismiss
	
	@State private var workOutType = "Weights"
	let workOuts = ["Weights", "Run/Walk", "Sports"]
	
	@State private var weightsTotal = ""
	@State private var runWalkTotal = ""
	@State private var sportsTotal = ""
	
    var body: some View {
		NavigationView {
			Form {
				Section(footer: Text("Weights")) {
					Text("Time spent lifting weights")
						.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					TextField("Time in minutes", text: $weightsTotal)
						.padding()
						.cornerRadius(20)
				}
				
				Section(footer: Text("Running")) {
					Text("Distance ran")
						.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					TextField("Distance in miles", text: $runWalkTotal)
						.padding()
						.cornerRadius(20)
				}
				
				Section(footer: Text("Sports")) {
					Text("Time spent playing sports")
						.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					TextField("Time in minutes", text: $sportsTotal)
						.padding()
						.cornerRadius(20)
				}
			}
			.toolbar {
				Button("ADD") {
					dismiss()
				}
				.font(.system(size: 20, weight: .bold, design: .default))
				.foregroundColor(disableForm ? .white : .green)
				.disabled(disableForm)
			}
		}
    }
	
	
	var disableForm: Bool {
		if (weightsTotal.isEmpty == false && checkIfNumber(input: weightsTotal) || runWalkTotal.isEmpty == false && checkIfNumber(input: runWalkTotal) || sportsTotal.isEmpty == false && checkIfNumber(input: sportsTotal)) {
			return false
		}
		return true
	}
	
	
	func checkIfNumber(input: String) -> Bool {
		let characters = CharacterSet.decimalDigits
		return CharacterSet(charactersIn: input).isSubset(of: characters)
	}
}

struct AddWorkOutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkOutView()
    }
}
