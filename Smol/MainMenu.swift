//
//  MainMenu.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit

class MainMenu: NSMenu {
    init() {
        super.init(title: "Smol")
        
        let appMenuItem = NSMenuItem()
        appMenuItem.submenu = NSMenu(title: "Smol")
        items = [appMenuItem]
        
        let quitMenuItem = NSMenuItem(
            title: "Quit Smol",
            action: #selector(NSApplication.terminate(_:)),
            keyEquivalent: "q"
        )
        appMenuItem.submenu?.items = [quitMenuItem]
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
