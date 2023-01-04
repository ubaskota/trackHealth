//
//  ProfileDetailView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/16/22.
//

import SwiftUI

struct ProfileDetailView: View {
	var profileItem: ProfileItem
	@State var showEditView = false
	@Environment(\.dismiss) var dismiss
	
    var body: some View {
		VStack (spacing: 30) {
			Text("Display Name : \(profileItem.getProfileDetails(requestType: "name"))")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			Text("Age : \(profileItem.getProfileDetails(requestType: "age")) years")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			Text("Height : \(profileItem.getProfileDetails(requestType: "height")) feet")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			Text("Weight : \(profileItem.getProfileDetails(requestType: "weight"))")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			Text("Ethnicity: \(profileItem.getProfileDetails(requestType: "race"))")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			Text("gender : \(profileItem.getProfileDetails(requestType: "gender"))")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			Text("Any known sleep issue/s : \(profileItem.getProfileDetails(requestType: "knownIssue"))")
				.font(.system(size: 16, weight: .bold, design: .default)).foregroundColor(Color.green)
				.padding([.top, .bottom])
			
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button(action: {
							self.showEditView.toggle()
						}) {
							Image(systemName: "pencil")
								.resizable()
								.aspectRatio(contentMode: .fill)
								.frame(width: 40, height: 40)
								.clipped()
								.foregroundColor(.green)
						}.sheet(isPresented: $showEditView) {
							ProfileEditView(profileItem: ProfileItem())
						}
					}
				}
			VStack(alignment: .trailing) {
				Text("Contact us: tracksleephealth@gmail.com")
					.fontWeight(.bold)
					.font(.system(size: 16))
					.foregroundColor(.green)
			}
			.padding(.vertical)
			.frame(maxWidth: 430, maxHeight: 80)
			.scaledToFill()
			.background(.lightBackground)
//			Button(action: {
//				self.showEditView.toggle()
//			}) {
//				Image(systemName: "pencil")
//					.resizable()
//					.aspectRatio(contentMode: .fill)
//					.frame(width: 50, height: 50)
//					.clipped()
//					.foregroundColor(.blue)
//			}.sheet(isPresented: $showEditView) {
//				ProfileEditView(profileItem: ProfileItem())
//			}
		}
    }
}


struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(profileItem: ProfileItem())
    }
}
