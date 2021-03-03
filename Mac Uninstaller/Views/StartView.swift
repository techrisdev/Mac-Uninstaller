// StartView.swift
//
// Created by TeChris on 20.01.21.

import SwiftUI

struct StartView: View {
	@State private var currentView = CurrentView.startView
	@State private var chosenApp = ""
	@State private var showingChooseSpaceOptionAlert = false
    var body: some View {
		if currentView == .startView {
			VStack {
				Title(text: "Welcome!")
					.padding(.top)
				
				Image("icon")
					.resizable()
					.frame(width: 300, height: 300)
				
				Button(action: {
					let panel = NSOpenPanel()
					panel.directoryURL = URL(fileURLWithPath: "/Applications", isDirectory: true)
					panel.allowsMultipleSelection = false
					panel.canChooseDirectories = false
					panel.canChooseFiles = true
					panel.allowedFileTypes = ["app"]
					panel.begin(completionHandler: { response in
						if response == .OK {
							if panel.url != nil {
								let appName = panel.url!.deletingPathExtension().lastPathComponent
								if containsSpace(appName) {
									chosenApp = appName
									showingChooseSpaceOptionAlert = true
								} else {
									chosenApp = appName
									currentView = .resultView
								}
							}
						}
					})
				}, label: {
					CustomButtonLabel(text: "Choose an App")
				})
				.buttonStyle(PlainButtonStyle())
				.alert(isPresented: $showingChooseSpaceOptionAlert, content: {
					spaceAlert()
				})
				.padding(2.5)
				
				Button(action: {
					currentView = .manualModeView
				}, label: {
					CustomButtonLabel(text: "Manual Mode")
				})
				.buttonStyle(PlainButtonStyle())
				.padding(.bottom, 27.5)
			}
		} else if currentView == .manualModeView {
			ManualModeView(chosenApp: $chosenApp, showingChooseSpaceOptionAlert: $showingChooseSpaceOptionAlert, currentView: $currentView)
		} else if currentView == .resultView {
			ResultView(appName: chosenApp, currentView: $currentView)
		}
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

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
