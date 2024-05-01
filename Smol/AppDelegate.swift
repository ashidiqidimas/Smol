//
//  AppDelegate.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let window = MainWindow(
            contentRect: NSRect(origin: .zero, size: .init(width: 320, height: 280))
        )
        window.center()
        
        let vc = MainViewController()
        window.setContentViewController(vc)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}
