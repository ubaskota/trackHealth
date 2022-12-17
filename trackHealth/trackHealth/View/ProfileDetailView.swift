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
			Text("Hello, World!")
			Text("Display Name : \(profileItem.getProfileDetails(requestType: "name"))")
			Text("Age : \(profileItem.getProfileDetails(requestType: "age")) years")
			Text("Height : \(profileItem.getProfileDetails(requestType: "height")) feet")
			Text("Weight : \(profileItem.getProfileDetails(requestType: "weight"))")
			Text("racet : \(profileItem.getProfileDetails(requestType: "race"))")
			Text("gender : \(profileItem.getProfileDetails(requestType: "gender"))")
			Text("Any known sleep issue/s : \(profileItem.getProfileDetails(requestType: "knownIssue"))")
			
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
								.foregroundColor(.blue)
						}.sheet(isPresented: $showEditView) {
							ProfileEditView(profileItem: ProfileItem())
						}
					}
				}
			
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
