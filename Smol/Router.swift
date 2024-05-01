//
//  Router.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit

protocol StartScreenRouterProtocol {
    func routeToEditor(with url: URL)
}

class Router: StartScreenRouterProtocol {
    
    private let window: MainWindow
    
    init(window: MainWindow) {
        self.window = window
    }
    
    func routeToEditor(with url: URL) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else {
                assertionFailure("self should not be nil")
                return
            }
            window.setSizeWithAnimation(to: CGSize(width: 800, height: 600))
            window.styleMask.insert(.resizable)
        }
    }
    
}
