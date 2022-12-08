//
//  TestView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/3/22.
//

//import SwiftUI
//
//struct TestView: View {
//	@State private var foodOne: String = ""
//	@State private var distanceOne: Int16 = 0
//	@Environment(\.dismiss) var dismiss
//
//    var body: some View {
//		NavigationView {
//			Form {
//				TextField("Food One", text: $foodOne)
//				TextField("Food One", value: $distanceOne, formatter: NumberFormatter())
//			}
//			.toolbar {
//				Button("ADD") {
//					print("This is the food: \(foodOne), and this is the distance : \(distanceOne)")
//					dismiss()
//				}
//				.font(.system(size: 20, weight: .bold, design: .default))
//				.disabled(foodOne.isEmpty || foodOne.count < 3 || distanceOne <= 0)
//			}
//		}
//    }
//}
//
//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}




//
//  ReviewView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 11/18/22.
//



//
//struct ContentView: View {
//
//	let mainTopics: [String] = ["OldHistory", "Food", "Review"]
//
//	@ViewBuilder
//	var body: some View {
//		NavigationView {
//			ScrollView {
//				ForEach(mainTopics, id: \.self) { topic in
//					NavigationLink {
//						switch topic {
//						case "OldHistory":
//							OldHistoryView()
//						case "Review":
//							ReviewView()
//						default:
//							FoodView(mealItem: MealItem())
//						}
//					} label: {
//						Text(topic)
//					}
//				}
//			}
//			.navigationTitle("Track-Health")
//		}
//		.background(.darkBackground)
//		.navigationBarBackButtonHidden(true)
//	}
//}




//import SwiftUI
//
//struct OldHistoryView: View {
//	let viewOptions: [String] = ["historyOne", "record_history"]
//	let textOptions: [String: String] = ["historyOne":"Record", "record_history": "Results"]
//
//	@ViewBuilder
//	var body: some View {
//		ScrollView {
//			ForEach(viewOptions, id: \.self) { topic in
//				NavigationLink {
//					switch topic {
//					case "historyOne":
//						HistoryView()
//					default:
//						RecordHistoryView()
//					}
//				} label: {
//					VStack {
//						Text(topic!)
//					}
//				}
//			}
//		}
//	}
//}
//
//
//struct SleepView_Previews: PreviewProvider {
//	static var previews: some View {
//		SleepView()
//	}
//}
