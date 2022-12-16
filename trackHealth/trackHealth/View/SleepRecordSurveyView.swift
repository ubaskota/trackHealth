//
//  SleepRecordSurveyView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/2/22.
//

import SwiftUI


//@available(iOS 16.0, *)
struct SleepRecordSurveyView: View {
	
	var recordMessage: String
	@State var survey: Int16
	@ObservedObject var audioRecorder: AudioRecorder
	@State var showAlert: Bool
	
	@State private var displayNewView: Bool = false
	
	var body: some View {
		VStack {
			NavigationLink(destination: ContentView(), isActive: self.$displayNewView) { EmptyView() }
			Text(recordMessage)
			.font(.headline)
			.foregroundColor(.green)
			.frame(width: 350, height: 200)
			.background(.lightBackground)
			.padding([.top, .trailing])
			
			Text("How well did you sleep?")
				.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			RatingView(rating: $survey)
			.clipped()
			.frame(width: 250, height: 20)
			
			Button(action: {
				self.audioRecorder.saveSleepToCoreData(survey: survey); showAlert = true
			}) {
				Text("Submit Response")
					.font(.headline)
					.foregroundColor(.green)
					.padding()
					.frame(width: 300, height: 50)
					.background(.darkBackground)
					.cornerRadius(15.0)
			}
			.alert(isPresented: $showAlert){
				Alert(title: Text("Thanks for the response!"), message: Text("This rating will be used to produce the best result for you."), dismissButton: .default(Text("Done"), action: {
					self.displayNewView = true
				})
				)
			}
		}
		.navigationBarBackButtonHidden(true)
	}
}


struct RatingView: View {
	@Binding var rating: Int16
	
	var label = ""
	var maximumRating = 5
	
	var offImage: Image?
	var onImage = Image(systemName: "star.fill")
	
	var offColor = Color.gray
	var onColor = Color.yellow
	
	var body: some View {
		HStack {
			if label.isEmpty == false {
				Text(label)
			}
			ForEach(1..<maximumRating + 1, id: \.self) { number in
				image(for: number)
					.foregroundColor(number > rating ? offColor : onColor)
					.onTapGesture {
						rating = Int16(number)
					}
			}
		}
	}
	
	func image(for number: Int) -> Image {
		if number > rating {
			return offImage ?? onImage
		} else {
			return onImage
		}
	}
}

//@available(iOS 16.0, *)
struct SleepRecordSurveyView_Previews: PreviewProvider {
    static var previews: some View {
        SleepRecordSurveyView(recordMessage: "You've stopped your recording", survey: 1, audioRecorder: AudioRecorder(), showAlert: false)
    }
}
