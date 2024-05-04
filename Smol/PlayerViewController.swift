//
//  PlayerViewController.swift
//  Smol
//
//  Created by Dimas on 04/05/24.
//

import AppKit
import AVKit
import MacKit

class PlayerViewController: NSViewController {
    
    private let data: Data
    private let inputURL: URL
    private var videoDimensions = CGSize(width: 1920, height: 1080)
    
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
    
    init(data: Data) {
        self.data = data
        
        let tempDirectory = FileManager
            .default
            .temporaryDirectory

        self.inputURL = tempDirectory
            .appendingPathComponent("input.mp4")

        super.init(nibName: nil, bundle: nil)
        
        do {
            try data.write(to: inputURL)
        } catch {
            assertionFailure("Failed to write data to url")
        }
        
        Task {
            do {
                let asset = AVURLAsset(url: inputURL)
                guard let track = try await asset.loadTracks(withMediaType: .video).first else { return }
                let naturalSize = try await track.load(.naturalSize)
                let preferredTransform = try await track.load(.preferredTransform)
                let size = naturalSize.applying(preferredTransform)
                self.videoDimensions = size
                view.needsLayout = true
                view.layoutSubtreeIfNeeded()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NSView()

        view.addSubview(playerView)
        
        NSLayoutConstraint.activate([
            playerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            playerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor).withPriority(.defaultHigh),
            playerView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor).withPriority(.defaultHigh),
            
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: videoDimensions.height / videoDimensions.width).withPriority(.defaultHigh),
            playerView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, constant: -40).withPriority(.required),
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let player = AVPlayer(url: inputURL)
        playerView.player = player
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: EditorViewController.Constants.Player.minWidth),
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: EditorViewController.Constants.Player.minHeight)
            ])
        }
    }
    
}
