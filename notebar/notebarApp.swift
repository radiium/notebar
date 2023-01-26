//
//  notebarApp.swift
//  notebar
//
//  Created by amigamac on 25/01/2023.
//

import SwiftUI

@main
struct notebarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EmptyView()
                .frame(width: .zero)
        }
    }
}
