//
//  LoginView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/1/22.
//

import SwiftUI

struct LoginView: View {
	@Environment(\.managedObjectContext) var moc
	
	@State private var userName = ""
	@State private var password1 = ""
	@State private var password2 = ""
	
    var body: some View {
		VStack {
			Form {
				Text("Create your username and password")
					.font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color.green)
					.padding([.top, .bottom])
				TextField("Username", text: $userName)
					.padding()
//					.background()
					.cornerRadius(20)
				SecureField("Password", text: $password1)
					.padding()
//					.background()
					.cornerRadius(20)
				SecureField("re-type your password", text: $password1)
					.padding()
//					.background()
					.cornerRadius(20)
				Button(action: {
					let loginDetails = Login(context: moc)
					loginDetails.userName = userName
					loginDetails.password = password1
					
					do {
						try moc.save()
						print("Successfully saved..")
					} catch {
						print("Unexpected error: \(error).")
					}
				}) {
				  Text("Sign In")
					.font(.headline)
					.foregroundColor(.green)
					.padding()
					.frame(width: 300, height: 50)
					.background(.darkBackground)
					.cornerRadius(15.0)
				}
			}
		}
		.padding([.leading, .trailing], 30.0)
//		.background(.darkBackground)
	}
	
	var disableForm: Bool {
		if (userName.count > 4 && password1 == password2 && password1.count > 7) {
			return false
		}
		return true
	}
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
