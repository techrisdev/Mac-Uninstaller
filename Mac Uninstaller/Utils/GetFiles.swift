// GetFiles.swift
//
// Created by TeChris on 06.02.21.

import Foundation

func getFiles(for applicationName: String) -> [File] {
	
	var result = [File]()
	let userPath = "/Users/\(NSUserName())"
	let userLibraryPath = userPath + "/Library"
	let userApplicationSupportPath = userLibraryPath + "/Application Support"
	let searchPaths = [
		"/Applications",
		"/var/db/receipts",
		"/usr/local/bin",
		"/usr/local/share",
		"/Library",
		"/Library/Caches",
		"/Library/Application Support",
		"/Library/Logs",
		"/Library/LaunchAgents",
		"/Library/LaunchDaemons",
		"/Library/Receipts",
		"/Library/StartupItems",
		"/Library/PrivilegedHelperTools",
		"/Library/Preferences",
		"/Library/Extensions",
		"/Library/Frameworks",
		"/Library/PreferencePanes",
		"/Library/Apple/System/Library/Receipts",
		userApplicationSupportPath,
		userLibraryPath,
		userPath,
		"\(userPath)/Desktop",
		"\(userLibraryPath)/Cookies",
		"\(userLibraryPath)/Saved Application State",
		"\(userLibraryPath)/Caches",
		"\(userLibraryPath)/Containers",
		"\(userLibraryPath)/Application Scripts",
		"\(userLibraryPath)/Group Containers",
		"\(userLibraryPath)/LaunchAgents",
		"\(userLibraryPath)/Services",
		"\(userLibraryPath)/Preferences"
	]
	
	for path in searchPaths {
		result += searchForFiles(path: path, for: applicationName)
	}
	return result
}


func searchForFiles(path: String, for name: String) -> [File] {
	let fm = FileManager.default
	var contents = [String]()
	do {
		contents = try fm.contentsOfDirectory(atPath: path)
	} catch {
		print(path)
		print("You need to grant Full Disk Access.")
	}
	var result = [File]()
	for file in contents {
		if file.range(of: name, options: .caseInsensitive) != nil {
			result.append(File(path: path, name: file))
		}
	}
	
	return result
}
