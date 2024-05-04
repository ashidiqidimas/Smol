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

        let button = NSButton(title: "Button", target: nil, action: nil)
        button.isBordered = false
        button.identifier = .export
        button.backgroundColor = .systemBlue
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.attributedTitle =
            NSAttributedString(string: "Export", attributes: [
                .font: NSFont.preferredFont(forTextStyle: .title3),
                .foregroundColor: NSColor.white]
            )
        button.layer?.cornerRadius = 17

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 34)
        ])
        
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
