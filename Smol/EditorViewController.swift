//
//  EditorViewController.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import AppKit
import AVKit
import MacKit

class EditorViewController: NSViewController {
    
    private let data: Data
    
    init(data: Data) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var playerView: AVPlayerView = {
        let view = AVPlayerView().forAutoLayout()
        view.controlsStyle = .inline
        view.allowsMagnification = false
        view.allowsPictureInPicturePlayback = false
        view.allowsVideoFrameAnalysis = false
        view.showsFrameSteppingButtons = false
        view.showsSharingServiceButton = false
        view.showsFullScreenToggleButton = false
        
        return view
    }()
    
    override func loadView() {
        view = NSView()

        view.addSubview(playerView)
        playerView.edgesToSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempDirectory = FileManager
            .default
            .temporaryDirectory
        
        let inputURL = tempDirectory
            .appendingPathComponent("input.mp4")
        
        do {
            try data.write(to: inputURL)
        } catch {
            assertionFailure("Failed to write data to url")
        }
        
        let player = AVPlayer(url: inputURL)
        playerView.player = player
    }
    
}
