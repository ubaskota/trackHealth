//
//  ContentView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/25/22.
//

import SwiftUI

struct ContentView: View {
//	@StateObject private var dataController = DataController()
//	@FetchRequest(sortDescriptors: []) var profileInfo: FetchedResults<Profile>
	
	@State var showingProfile = false;
	let mainTopics: [String] = ["Food", "Workout", "Sleep", "Review"]
	var topicImage : [String: String] = ["food": "foodImg", "Workout": "workoutImg", "Sleep": "sleepImg", "Review": "reviewImg"]
	
	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(mainTopics, id: \.self) { topic in
					
					NavigationLink {
						switch topic {
//						case "Food":
//							FoodView(mealItem: MealItem())
						case "Workout":
							WorkoutView()
						case "Sleep":
							SleepView()
						case "Review":
							ReviewView(mealItem: MealItem())
						default:
							FoodView(mealItem: MealItem())
						}
					} label: {
					VStack {
						Image(topicImage[topic] ?? "foodImg")
							.resizable()
							.scaledToFit()
							.frame(width: 200, height: 200)
							.padding()
						
						VStack {
							Text(topic)
								.font(.headline)
								.foregroundColor(.green)
						}
						.padding(.vertical)
						.frame(maxWidth: .infinity)
						.background(.darkBackground)
						}
					.clipShape(RoundedRectangle(cornerRadius: 20))
					.overlay(RoundedRectangle(cornerRadius: 20)
						.stroke(.lightBackground))
					}
				}
				.padding([.horizontal, .bottom])
			}
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						self.showingProfile.toggle()
					}) {
						Text("Profile")
					}.sheet(isPresented: $showingProfile) {
						ProfileEditView(profileItem: ProfileItem())
					}
						.font(.system(size: 20, weight: Font.Weight.bold))
						.foregroundColor(Color.green)
				}
			}
			.navigationTitle("Track-Health")
		}
		.background(.darkBackground)
		.navigationBarBackButtonHidden(true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
