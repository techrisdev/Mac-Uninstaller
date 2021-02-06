// ResultView.swift
//
// Created by TeChris on 20.01.21.

import SwiftUI

struct ResultView: View {
	var appName: String
	@State private var files = [File]()
	@State private var trashError = false
	@State private var protectedFile = URL(fileURLWithPath: "")
	@State private var fullDiskAccessError = false
	@State private var deleteAllAlert = false
	@Binding var currentView: CurrentView
    var body: some View {
		ZStack {
			VStack {
				HStack {
					BackButton(currentView: $currentView)
					
					Spacer()
					
					Text("Items: \(files.count)")
						.padding(.trailing, 2.5)
					
					Button(action: {
						files = getFiles(for: "\(appName)")
					}, label: {
						Text("􀅉")
					})
					.padding(.trailing)
					.buttonStyle(PlainButtonStyle())
				}
				.padding(.top)
				
				ScrollView {
					ForEach(files) { file in
						Button(action: {
							do {
								try FileManager.default.trashItem(at: URL(fileURLWithPath: "\(file.path)/\(file.name)"), resultingItemURL: nil)
							} catch {
								protectedFile = URL(fileURLWithPath: "\(file.path)/\(file.name)")
								trashError = true
							}
							files = getFiles(for: "\(appName)")
						}, label: {
							HStack {
								Text("\(file.path)/\(file.name)")
									.padding(7.5)
								
								Spacer()
								
								CustomButtonLabel(text: "Move to Trash")
								
							}
						})
						.buttonStyle(PlainButtonStyle())
					}
					.onAppear(perform: {
						if checkForFullDiskAccess() {
							files = getFiles(for: "\(appName)")
							
						} else {
							// show error
							fullDiskAccessError = true
						}
					})
					.alert(isPresented: $fullDiskAccessError, content: {
						Alert(title: Text("Full Disk Access"), message: Text("You need to grant Full Disk Access for this App to work."), dismissButton: .default(Text("OK")))
					})
					.alert(isPresented: $trashError, content: {
						Alert(title: Text("Administrator Privileges"), message: Text("This File needs Administrator Privileges to be removed. Please delete it yourself."), dismissButton: .default(Text("Show in Finder"), action: {
							NSWorkspace.shared.activateFileViewerSelecting([protectedFile])
						}))
					})
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				}
				.padding()
				
				HStack {
					Button(action: {
						deleteAllAlert = true
					}, label: {
						HStack {
							Spacer()
							ZStack {
								Color.red
								Text("Trash All")
									.fontWeight(.bold)
									.foregroundColor(.white)
							}
							.frame(width: 125, height: 40)
							.cornerRadius(12.5)
							.shadow(radius: 10)
							.padding(7.5)
							Spacer()
						}
					})
					.alert(isPresented: $deleteAllAlert, content: {
						Alert(title: Text("Proceed"), message: Text("Are you sure you want to delete all found Files?"), primaryButton: .cancel(), secondaryButton: .default(Text("Delete All"), action: {
							for file in files {
								do {
									try FileManager.default.trashItem(at: URL(fileURLWithPath: "\(file.path)/\(file.name)"), resultingItemURL: nil)
								} catch {
									//Show error user needs to trash
									print("trash error")
								}
								files = getFiles(for: "\(appName)")
							}
						}))
					})
					.buttonStyle(PlainButtonStyle())
				}
				.padding(.bottom)
				.frame(maxWidth: .infinity, alignment: .bottom)
				.frame(height: 70)
				Spacer()
			}
		}
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
		Text("I don't need Previews :)")
    }
}

