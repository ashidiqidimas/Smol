//
//  EditorViewController.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import AppKit

class EditorViewController: NSSplitViewController {
    
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
        inspectorItem.minimumThickness = 220
        inspectorItem.maximumThickness = 320
        addSplitViewItem(inspectorItem)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
