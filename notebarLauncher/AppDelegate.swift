//
//  AppDelegate.swift
//  notebarLauncher
//
//  Created by amigamac on 26/01/2023.
//

import Cocoa

class NotebarLauncherAppDelegate: NSObject, NSApplicationDelegate {

    struct Constants {
        static let mainAppBundleId = "com.radiium.notebar"
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = runningApps.contains {
            $0.bundleIdentifier == Constants.mainAppBundleId
        }
        
        if !isRunning {
            var path = Bundle.main.bundlePath as NSString
            for _ in 1...4 {
                path = path.deletingLastPathComponent as NSString
            }
            let applicationPathString = path as String
            guard let pathUrl = URL(string: applicationPathString) else { return }
            NSWorkspace.shared.openApplication(
                at: pathUrl,
                configuration: NSWorkspace.OpenConfiguration(),
                completionHandler: nil
            )
        }
    }
}

