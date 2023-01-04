//
//  WorkoutView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 6/2/22.
//

import SwiftUI

struct WorkoutView: View {
	@State private var showingAddWorkout = false
	var workOutItem: WorkOutItem
	
    var body: some View {
		VStack {
			VStack {
				Text("Add your workout")
					.fontWeight(.bold)
					.font(.title)
					.font(.system(size: 20))
					.foregroundColor(.green)
			}
			.padding(.vertical)
			.frame(maxWidth: 430, maxHeight: 80)
			.scaledToFill()
			.background(.lightBackground)
			
			
			NavigationView {
				VStack (spacing: 30) {
					Text("Your Average workout so far: ")
						.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					Text("Weights: \(workOutItem.getAverageWeightsTime()) minutes")
						.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					Text("Run/Walk: \(workOutItem.getAverageDistance()) miles")
						.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					Text("Sports: \(workOutItem.getAverageSportsTime()) minutes")
						.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
						.padding([.top, .bottom])
					.toolbar {
						Button {
							showingAddWorkout = true
						} label : {
							Image(systemName: "plus")
								.renderingMode(.original)
								.font(.system(size: 60))
								.foregroundColor(Color(.systemRed))
						}
					}
						.sheet(isPresented: $showingAddWorkout) {
							AddWorkOutView(workOutItem: WorkOutItem())
						}
				}
			}
		}
		
		ZStack {
			Image("healthy")
				.resizable()
				.scaledToFit()
				.edgesIgnoringSafeArea(.all)
				.frame(width: 180, height: 130)
				.clipShape(Ellipse())
		}
		.background(
			Ellipse()
				.frame(width: 50, height: 50))
	}
}


struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workOutItem: WorkOutItem())
    }
}
