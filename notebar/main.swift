//
//  main.swift
//  notebar
//
//  Created by amigamac on 27/01/2023.
//

import Cocoa

let delegate = NotebarAppDelegate()
let app = NSApplication.shared
app.delegate = delegate
app.setActivationPolicy(.accessory)
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
