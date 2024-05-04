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
                navigator.routeToEditor(with: data)
            } catch {
                handle(error)
            }
        case .userDidDropFile(let data):
            navigator.routeToEditor(with: data)
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

protocol DropHandlerProtocol: AnyObject {
    func setHighlighted(to highlighted: Bool)
    func handle(_ error: Error)
    func onDrop(data: Data)
}

class DropListener: DropDelegate {
    
    enum Error: Swift.Error {
        case invalidData
        case failedToLoadData
    }
    
    weak var handler: DropHandlerProtocol?

    func dropEntered(info: DropInfo) {
        handler?.setHighlighted(to: true)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [.movie, .video]) else {
            handler?.handle(Error.invalidData)
            return false
        }
        
        if let item = info.itemProviders(for: [.movie]).first {
            _ = item.loadDataRepresentation(for: .movie) { data, error in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.handler?.handle(error!)
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data {
                        self?.handler?.onDrop(data: data)
                    } else {
                        self?.handler?.handle(Error.failedToLoadData)
                    }
                }
            }
        } else if let item = info.itemProviders(for: [.video]).first {
            _ = item.loadDataRepresentation(for: .video) { data, error in
                guard error == nil else {
                    DispatchQueue.main.async { [weak self] in
                        self?.handler?.handle(error!)
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data {
                        self?.handler?.onDrop(data: data)
                    } else {
                        self?.handler?.handle(Error.failedToLoadData)
                    }
                }
            }
        }
        
        return true
    }
    
    func dropExited(info: DropInfo) {
        handler?.setHighlighted(to: false)
    }
    
}
