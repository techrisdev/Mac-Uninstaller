// FullDiskAccess.swift
//
// Created by TeChris on 06.02.21.

import Foundation

// Because currently, the App isn't sandboxed, this Function is not needed.
func checkForFullDiskAccess() -> Bool {
	let check = try? FileManager.default.contentsOfDirectory(atPath: "/")
	if check != nil {
		return true
	} else {
		return false
	}
}
