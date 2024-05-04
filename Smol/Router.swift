//
//  Router.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import AppKit

protocol StartScreenRouterProtocol {
    func routeToEditor(with data: Data, delayAnimation: Bool)
}

class Router: StartScreenRouterProtocol {
    
    private let window: MainWindow
    
    init(window: MainWindow) {
        self.window = window
    }
    
    func routeToEditor(with data: Data, delayAnimation: Bool) {
        
        let editorVC = EditorViewController(data: data)
        window.setContentViewController(editorVC)
        
        let delayTime = delayAnimation ? 0.2 : 0.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) { [weak self] in
            guard let self else {
                assertionFailure("self should not be nil")
                return
            }
            window.setSizeWithAnimation(to: EditorViewController.Constants.windowSize)
            window.styleMask.insert(.resizable)
        }
    }
    
}
