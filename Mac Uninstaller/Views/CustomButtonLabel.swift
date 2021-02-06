// CustomButtonLabel.swift
//
// Created by TeChris on 06.02.21.

import SwiftUI

struct CustomButtonLabel: View {
	var text: String
	var body: some View {
		ZStack {
			Color("theme-color")
			Text(text)
				.fontWeight(.bold)
				.foregroundColor(.white)
		}
		.frame(width: 130, height: 45)
		.cornerRadius(12.5)
		.shadow(radius: 10)
		.padding(7.5)
	}
}
