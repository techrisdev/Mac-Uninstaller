// AppDelegate.swift
//
// Created by TeChris on 20.01.21.

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

	var window: NSWindow!

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Create the SwiftUI view that provides the window contents.
		let startView = StartView()
		
		// Create the window and set the content view.
		window = NSWindow(
		    contentRect: NSRect(x: 0, y: 0, width: 500, height: 280),
		    styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
		    backing: .buffered, defer: false)
		window.isReleasedWhenClosed = false
		window.center()
		window.contentView = NSHostingView(rootView: startView)
		window.makeKeyAndOrderFront(nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

