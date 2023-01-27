//
//  AppDelegate.swift
//  notebar
//
//  Created by amigamac on 25/01/2023.
//

import Foundation
import AppKit
import SwiftUI

final class NotebarAppDelegate: NSObject, NSApplicationDelegate {
    
    private var menuExtrasConfigurator: MacExtrasConfigurator?
    
    final private class MacExtrasConfigurator: NSObject {
        private var statusItem: NSStatusItem!
        private var statusItemMenu: NSMenu!
        
        // MARK: - Lifecycle
        
        override init() {
            super.init()
            self.statusItem = self.buildStatusItem()
            self.statusItemMenu = self.buildStatusItemMenu()
            // self.testReadNotesFromNotesApp()
        }
             
        /*
         // FIXME
         Read notes content with applescript
         not working for now
        
         private func testReadNotesFromNotesApp() {
            let source = """
              tell application "Notes"
                repeat with theNote in notes
                  set theNoteName to name of theNote
                  log theNoteName

                  set theNoteBody to body of theNote
                  log theNoteBody

                  log "----"
                end repeat
              end tell
            """

            if let script = NSAppleScript(source: source) {
                var error: NSDictionary?
                let evt = script.executeAndReturnError(&error) as NSAppleEventDescriptor
                print((evt.stringValue ?? "no response") as String)
                if let err = error {
                    print(err)
                }
            }
        }
        */
        
        // MARK: - Private
        
        // MARK: - MenuConfig
        
        private func buildStatusItemMenu() -> NSMenu {
            let statusItemMenu = NSMenu()
            statusItemMenu.addItem(NSMenuItem(title: "Open Notes app", action: #selector(openNotesApp), keyEquivalent: ""))
            statusItemMenu.addItem(NSMenuItem.separator())
            statusItemMenu.addItem(NSMenuItem(title: "About NoteBar \(Bundle.main.releaseVersionNumberPretty)", action: #selector(openAppPage), keyEquivalent: ""))
            statusItemMenu.addItem(NSMenuItem(title: "Quit App", action: #selector(quitApp), keyEquivalent: "q"))
            
            statusItemMenu.items.forEach { $0.target = self }
            return statusItemMenu
        }
        
        private func buildStatusItem() -> NSStatusItem {
            let statusItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
            
            statusItem.button?.image = NSImage(named: "AppIconStatus")
            statusItem.button?.target = self
            statusItem.button?.action = #selector(onClick(_:))
            statusItem.button?.sendAction(on: [.leftMouseUp, .rightMouseUp])
            return statusItem
        }
        
        // MARK: - Actions
        
        @objc private func openAppPage(_ sender: Any?) {
            if let url = URL(string: "https://github.com/radiium/notebar") {
                NSWorkspace.shared.open(url)
            }
        }
        
        @objc private func openNotesApp(_ sender: Any?) {
            if let notesApp = FileManager.default.urls(for: .applicationDirectory, in: .systemDomainMask).first?.appendingPathComponent("Notes.app") {
                let response = NSWorkspace.shared.open(notesApp)
                print(response)
            }
        }
        
        @objc private func quitApp(_ sender: Any?) {
            NSApplication.shared.terminate(self)
        }
        
        @objc private func onClick(_ sender: Any?) {
            let event = NSApp.currentEvent!
            if event.type == NSEvent.EventType.leftMouseUp {
                self.openNotesApp(sender)
            } else if event.type == NSEvent.EventType.rightMouseUp {
                self.statusItem.menu = self.statusItemMenu
                self.statusItem.button?.performClick(nil)
                self.statusItem.menu = nil
            }
        }
    }
    
    // MARK: - NSApplicationDelegate
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        menuExtrasConfigurator = .init()
    }
}
