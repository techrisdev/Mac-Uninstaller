// ManualModeView.swift
//
// Created by TeChris on 05.02.21.

import SwiftUI

struct ManualModeView: View {
	@Binding var chosenApp: String
	@Binding var showingChooseSpaceOptionAlert: Bool
	@Binding var currentView: CurrentView
    var body: some View {
		HStack {
			BackButton(currentView: $currentView)
			
			Spacer()
		}
		.padding(.top)
		
		Title(text: "Manual Mode")
		
		Text("􀥏")
			.font(.system(size: 125))
		
		if #available(OSX 11.0, *) {
			TextField("App Name", text: $chosenApp)
				.frame(width: 350)
				.accentColor(Color("theme-color"))
				.padding()
		} else {
			TextField("App Name", text: $chosenApp)
				.frame(width: 350)
				.padding()
		}
			
		Button(action: {
			if containsSpace(chosenApp) {
				showingChooseSpaceOptionAlert = true
			} else {
				currentView = .resultView
			}
		}, label: {
			CustomButtonLabel(text: "Continue")
		})
		.buttonStyle(PlainButtonStyle())
		.alert(isPresented: $showingChooseSpaceOptionAlert, content: {
			spaceAlert()
		})
		.padding()
		.frame(maxWidth: 300, maxHeight: 400)
    }
	
	func spaceAlert() -> Alert {
		Alert(title: Text("Choose"), message: Text("This app contains a space. Select for what you want to search."), primaryButton: .default(Text(chosenApp.components(separatedBy: " ")[1]), action: {
			chosenApp = chosenApp.components(separatedBy: " ")[1]
			currentView = .resultView
		}), secondaryButton: .default(Text(chosenApp.components(separatedBy: " ")[0]), action: {
			chosenApp = chosenApp.components(separatedBy: " ")[0]
			currentView = .resultView
		}))
	}
}

struct ManualModeView_Previews: PreviewProvider {
    static var previews: some View {
		Text("I don't need Previews :)")
    }
}
