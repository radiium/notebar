//
//  main.swift
//  notebarLauncher
//
//  Created by amigamac on 26/01/2023.
//

import Cocoa

let delegate = NotebarLauncherAppDelegate()
let app = NSApplication.shared
app.delegate = delegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
