//
//  StartScreenViewModel.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

class StartScreenViewModel: ObservableObject {
    
    private let navigator: StartScreenRouterProtocol
    let dropListener: DropListener
    
    init(navigator: StartScreenRouterProtocol) {
        self.navigator = navigator
        self.dropListener = DropListener()
        self.dropListener.handler = self
    }
    
    enum Action {
        case userDidTapImportButton
        case userDidSelectFile(URL)
        case userDidDropFile(Data)
    }
    
    @Published var isImporting = false
    @Published private(set) var isHighlighting = false
    
    func perform(action: Action) {
        switch action {
        case .userDidTapImportButton:
            isImporting = true
        case .userDidSelectFile(let url):
            isImporting = false
            do {
                let data = try Data(contentsOf: url)
                navigator.routeToEditor(with: data, delayAnimation: true)
            } catch {
                handle(error)
            }
        case .userDidDropFile(let data):
            navigator.routeToEditor(with: data, delayAnimation: false)
        }
    }
    
    func handle(_ error: Error) {
        fatalError(error.localizedDescription)
    }
    
}

extension StartScreenViewModel: DropHandlerProtocol {
    
    func setHighlighted(to highlighted: Bool) {
        isHighlighting = highlighted
    }
    
    func onDrop(data: Data) {
        perform(action: .userDidDropFile(data))
    }
    
}

