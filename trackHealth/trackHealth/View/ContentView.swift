//
//  ContentView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 5/25/22.
//

import SwiftUI

//@available(iOS 16.0, *)
struct ContentView: View {
	
	@State var showingProfile = false;
	let mainTopics: [String] = ["Sleep", "Food", "Workout", "Review"]
	var topicImage : [String: String] = ["food": "foodImg", "Workout": "workoutImg", "Sleep": "sleepImg", "Review": "reviewImg"]
	
	var body: some View {
		NavigationView {
			ScrollView {
				ForEach(mainTopics, id: \.self) { topic in
					
					NavigationLink {
						switch topic {
						case "Workout":
							WorkoutView(workOutItem: WorkOutItem())
						case "Sleep":
							SleepView()
						case "Review":
//							ReviewView(reviewItem: ReviewItem())
							ReviewListView()
						default:
							FoodView(mealItem: MealItem())
						}
					} label: {
					VStack {
						NavigationLink(destination: ProfileDetailView(profileItem: ProfileItem()), isActive: self.$showingProfile) { EmptyView()}
						
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
					}
//					.sheet(isPresented: $showingProfile) {
////						ProfileEditView(profileItem: ProfileItem())
//						ProfileDetailView(profileItem: ProfileItem())
//					}
						.font(.system(size: 20, weight: Font.Weight.bold))
						.foregroundColor(Color.green)
				}
			}
			.navigationTitle("trackHealth")
		}
		.background(.darkBackground)
		.navigationBarBackButtonHidden(true)
    }
}


//@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
