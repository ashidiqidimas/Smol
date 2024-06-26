//
//  MainWindow.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit
import MacKit

class MainWindow: NSWindow {
    init(contentRect: NSRect) {
        super.init(
            contentRect: contentRect,
            styleMask: [.closable, .miniaturizable, .fullSizeContentView, .titled],
            backing: .buffered,
            defer: false
        )
        
        titlebarAppearsTransparent = true
        titleVisibility  = .hidden
    }
}
