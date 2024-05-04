//
//  EditorToolbar.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import AppKit

class EditorToolbar: NSToolbar {
    init() {
        super.init(identifier: "EditorToolbar")
        
        delegate = self
        
        allowsUserCustomization = false
        displayMode = .iconOnly
    }
}

extension EditorToolbar: NSToolbarDelegate {
    func toolbar(
        _ toolbar: NSToolbar,
        itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
        willBeInsertedIntoToolbar flag: Bool
    ) -> NSToolbarItem? {
        switch itemIdentifier {
        case .export:
            return makeExportButton()
        default:
            return nil
        }
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [.sidebarTrackingSeparator, .export, .flexibleSpace, .inspectorTrackingSeparator]
    }
    
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        [.flexibleSpace, .export, .inspectorTrackingSeparator, .flexibleSpace]
    }

    private func makeExportButton() -> NSToolbarItem{
        let item = NSToolbarItem(itemIdentifier: .export)

        let button = ButtonLabel(title: "Export")
            .withSize(.small)
            .withCornerStyle(.rounded)
            .forAutoLayout()
        button.isBordered = false
        button.identifier = .export
        button.backgroundColor = .systemBlue
        item.view = button
        
        return item
    }
}

private extension NSToolbarItem.Identifier {
    static let export: NSToolbarItem.Identifier = .init(rawValue: "export")
}

private extension NSUserInterfaceItemIdentifier {
    static let export = NSUserInterfaceItemIdentifier("export")
}
