//
//  EditorViewController.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import AppKit

class EditorViewController: NSSplitViewController {
    
    enum Constants {
        static let windowSize = CGSize(width: 800, height: 600)
        
        enum Inspector {
            static let minWidth = CGFloat(220)
            static let maxWidth = CGFloat(320)
        }
        
        enum Player {
            static let minWidth = windowSize.width - Inspector.maxWidth
            static let minHeight = windowSize.height
        }
    }
    
    private let data: Data
    
    init(data: Data) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
        
        let playerVC = PlayerViewController(data: data)
        let playerItem = NSSplitViewItem(viewController: playerVC)
        playerItem.canCollapse = false
        addSplitViewItem(playerItem)
        
        let inspectorVC = RightSidebarViewController()
        let inspectorItem = NSSplitViewItem(inspectorWithViewController: inspectorVC)
        inspectorItem.canCollapse = false
        inspectorItem.minimumThickness = Constants.Inspector.minWidth
        inspectorItem.maximumThickness = Constants.Inspector.maxWidth
        addSplitViewItem(inspectorItem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
