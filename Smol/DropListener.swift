//
//  DropListener.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import SwiftUI

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
