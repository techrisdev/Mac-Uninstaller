// Title.swift
//
// Created by TeChris on 06.02.21.

import SwiftUI

struct Title: View {
	var text: String
    var body: some View {
		Text(text)
			.font(.title)
			.fontWeight(.bold)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.padding()
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
		Title(text: "Preview")
    }
}
