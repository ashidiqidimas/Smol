//
//  MainViewController.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit
import SwiftUI
import MacKit

class MainViewController: NSViewController {
    override func loadView() {
        view = NSView()
//        view.backgroundColor = .systemBlue
        
        let startView = NSHostingController(rootView: StartView())
        startView.view.forAutoLayout()
        view.addSubview(startView.view)
        addChild(startView)
        NSLayoutConstraint.activate([
            startView.view.topAnchor.constraint(equalTo: view.topAnchor),
            startView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
