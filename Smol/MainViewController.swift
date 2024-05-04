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
    
    weak private var window: NSWindow?
    
    init(window: NSWindow) {
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView()
        
        guard let window = window as? MainWindow else {
            assertionFailure("window's type should be MainWindow")
            return
        }
        
        let startScreenViewModel = StartScreenViewModel(navigator: window.router)
        
        let startView = NSHostingController(rootView: StartView(viewModel: startScreenViewModel))
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
