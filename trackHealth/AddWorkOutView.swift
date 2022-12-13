//
//  AddWorkOutView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/11/22.
//

import SwiftUI

//Later you need to add a function where an user can add sections as per requirement and pick the category from the picker. Initially we need to present only one form

struct AddWorkOutView: View {
	@Environment(\.dismiss) var dismiss
	var workOutItem: WorkOutItem
	
	@State private var workOutType = "Weights"
	@State private var weightsTotal = ""
	@State private var runWalkTotal = ""
	@State private var sportsTotal = ""
//	@State private var displayNewView = false
	
    var body: some View {
		NavigationView {
			VStack {
//				NavigationLink(destination: ContentView(), isActive: self.$displayNewView) { EmptyView() }
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
						self.workOutItem.saveWorkOutToCoredata(weightsTotal: Int32(weightsTotal) ?? 0, runWalkTotal: Float(runWalkTotal) ?? 0, sportsTotal: Int32(sportsTotal) ?? 0)
						dismiss()
//						self.displayNewView = true
					}
					.font(.system(size: 20, weight: .bold, design: .default))
					.foregroundColor(disableForm ? .white : .green)
					.disabled(disableForm)
				}
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
		AddWorkOutView(workOutItem: WorkOutItem())
    }
}
