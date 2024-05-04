//
//  MainWindow.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit
import MacKit

class MainWindow: NSWindow {
    
    private(set) var router: Router!
    
    init(contentRect: NSRect) {
        super.init(
            contentRect: contentRect,
            styleMask: [.closable, .miniaturizable, .fullSizeContentView, .titled],
            backing: .buffered,
            defer: false
        )
        
        router = Router(window: self)
   
        title = "Smol"
        titlebarAppearsTransparent = true
        titleVisibility  = .hidden
    }
    
    override func close() {
        let app = NSApplication.shared
        app.terminate(nil)
    }
    
}
