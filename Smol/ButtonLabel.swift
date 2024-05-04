//
//  ButtonLabel.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import AppKit
import MacKit

struct ButtonConfiguration {
    var buttonSize: ButtonSize = .medium
    var cornerStyle: CornerStyle = .medium
    
    var height: CGFloat {
        buttonSize.height()
    }
    
    var horizontalPadding: CGFloat {
        buttonSize.horizontalPadding()
    }
}

enum ButtonSize {
    case extraSmall
    case small
    case medium
    case large
    case extraLarge
    case custom((height: CGFloat, horizontalPadding: CGFloat))
    
    func height() -> CGFloat {
        switch self {
            case .extraSmall:
            return 28
        case .small:
            return 32
        case .medium:
            return 36
        case .large:
            return 40
        case .extraLarge:
            return 44
        case .custom(let size):
            return size.height
        }
    }
    
    func horizontalPadding() -> CGFloat {
        switch self {
        case .extraSmall:
            return 12
        case .small, .medium:
            return 16
        case .large, .extraLarge:
            return 24
        case .custom(let size):
            return size.horizontalPadding
        }
    }
}

enum CornerStyle {
    case rounded
    case medium
    case constant(CGFloat)
    
    func radius(for height: CGFloat) -> CGFloat {
        switch self {
        case .rounded:
            return height / 2
        case .medium:
            return 8
        case .constant(let cGFloat):
            return cGFloat
        }
    }
}

class ButtonLabel: NSButton {
    
    private lazy var label: NSTextField = {
        let view = NSTextField(labelWithString: "").forAutoLayout()
        view.textColor = .white
        view.alignment = .center
        view.font = .preferredFont(forTextStyle: .title3)
        
        return view
    }()
    
    private var isMouseDown = false
    
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    
    private var configuration = ButtonConfiguration()
    
    init(title: String) {
        super.init(frame: .zero)
        
        backgroundColor = .systemBlue
        isBordered = false
        
        
        label.stringValue = title
        
        let labelSize = label.intrinsicContentSize
        
        addSubview(label)
        widthConstraint = widthAnchor.constraint(equalToConstant: labelSize.width + (configuration.horizontalPadding * 2))
        heightConstraint = heightAnchor.constraint(equalToConstant: ButtonSize.medium.height())
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthConstraint,
            heightConstraint
        ])
        
        layer?.cornerRadius = configuration.cornerStyle.radius(for: heightConstraint.constant)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func withSize(_ size: ButtonSize) -> Self {
        configuration.buttonSize = size
        heightConstraint.constant = size.height()
        widthConstraint.constant = label.intrinsicContentSize.width + (size.horizontalPadding() * 2)
        return self
    }
    
    func withCornerStyle(_ style: CornerStyle) -> Self {
        configuration.cornerStyle = style
        layer?.cornerRadius = configuration.cornerStyle.radius(for: heightConstraint.constant)
        return self
    }
    
    // expected to empty because we will draw by ourself
    override func draw(_ dirtyRect: NSRect) {}

    override func mouseDown(with event: NSEvent) {
        isMouseDown = true
        animateState()
    }
    
    override func mouseUp(with event: NSEvent) {
        isMouseDown = false
        animateState()
        if frame.contains(event.locationInWindow) {
            _ = target?.perform(action)
        }
    }
    
    private func animateState() {
        if isMouseDown {
            alphaValue = 0.8
        } else {
            alphaValue = 1
        }
    }
    
}

#Preview {
    ButtonLabel(title: "Button")
}
