//
//  ReviewListView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/17/22.
//

import SwiftUI

struct ReviewListView: View {
	let viewOptions: [String] = ["weekly_result", "average_result"]
	let imageOptions: [String: String] = ["weekly_result": "weeklyImg", "average_result": "averageImg"]
	let textOptions: [String: String] = ["weekly_result":"Weekly Result", "average_result": "Average Result"]
	
	var body: some View {
		ScrollView {
				ForEach(viewOptions, id: \.self) { topic in
					NavigationLink {
						switch topic {
						case "average_result":
							ReviewView(reviewItem: ReviewItem())
						default:
//							SleepResultView()
							ReviewWeeklyView(reviewItem: ReviewItem())
						}
					} label: {
						VStack {
							Image(imageOptions[topic]!)
//							Text(imageOptions[topic]!)
								.resizable()
								.scaledToFit()
								.frame(width: 200, height: 200)
								.padding()
							VStack {
								Text(textOptions[topic]!)
								.font(.headline)
								.foregroundColor(.green)
						}
								.padding(.vertical)
								.frame(maxWidth: 100)
								.background(.darkBackground)
							}
						.clipShape(RoundedRectangle(cornerRadius: 10))
						.overlay(RoundedRectangle(cornerRadius: 10)
							.stroke(.lightBackground))
						.background(.darkBackground)
					}
				}
				.padding([.horizontal, .bottom])
				.background(.white)
			}
	}
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView()
    }
}
