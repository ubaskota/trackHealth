//
//  SleepResultRowView.swift
//  trackHealth
//
//  Created by Ujjwal Baskota on 12/10/22.
//

import SwiftUI

struct SleepResultRowView: View {
	var sleepScore = 0
	var fileName = ""
	
    var body: some View {
		HStack {
			Text("\(sleepScore)")
				.frame(width: 85, height: 60)
				.clipShape(Circle())
				.overlay(Circle().stroke(.gray, lineWidth: 3))
				.font(.largeTitle
					.weight(.bold))
				.foregroundColor(sleepScore > 80 ? .green: sleepScore > 50 && sleepScore < 80 ? .blue : .red)
			
			VStack(alignment: .leading) {
				Text(fileName)
					.font(.system(size: 16, design: .rounded))
			}
		}
	}
}


struct SleepResultRowView_Previews: PreviewProvider {
    static var previews: some View {
        SleepResultRowView()
    }
}
