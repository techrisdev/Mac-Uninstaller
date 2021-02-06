// BackButton.swift
//
// Created by TeChris on 06.02.21.

import SwiftUI

struct BackButton: View {
	@Binding var currentView: CurrentView
    var body: some View {
		Button(action: {
			currentView = .startView
		}, label: {
			Text("􀄪")
		})
		.padding(.leading)
		.buttonStyle(PlainButtonStyle())
    }
}

