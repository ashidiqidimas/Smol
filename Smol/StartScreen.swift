//
//  StartScreen.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import SwiftUI

struct StartView: View {
    
    enum Constants {
        static let windowSize = CGSize(width: 320, height: 280)
        static let padding = EdgeInsets(top: 48, leading: 40, bottom: 40, trailing: 40)
        static let contentSpacing = CGFloat(16)
        enum DropZone {
            static let cornerRadius = CGFloat(16)
            static let lineWidth = CGFloat(3)
            static let dashWhenHighlighted: [CGFloat] = []
            static let dashWhenUnhighlighted: [CGFloat] = [12]
            static let animationDuration = 0.2
        }
    }
    
    @ObservedObject private var vm: StartScreenViewModel
    
    init(viewModel: StartScreenViewModel) {
        self._vm = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.DropZone.cornerRadius)
                .fill(.clear)
                .stroke(
                    Color(nsColor: vm.isHighlighting ? NSColor.systemBlue : NSColor.tertiaryLabelColor),
                    style: .init(
                        lineWidth: Constants.DropZone.lineWidth,
                        lineCap: .round,
                        dash: vm.isHighlighting ? Constants.DropZone.dashWhenHighlighted : Constants.DropZone.dashWhenUnhighlighted
                    )
                )
                .animation(.easeInOut(duration: Constants.DropZone.animationDuration), value: vm.isHighlighting)
            
            VStack(spacing: Constants.contentSpacing) {
                Text("Drag your\nvideo here")
                    .font(.system(.title, design: .rounded))
                
                Text("OR")
                    .foregroundStyle(.secondary)
                
                Button {
                    vm.perform(action: .userDidTapImportButton)
                } label: {
                    Text("Select a File")
                        .font(.system(.title3, design: .rounded))
                        .padding(.horizontal, 12)
                        .frame(height: 36)
                        .background(.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .fileImporter(isPresented: $vm.isImporting,
                              allowedContentTypes: [.video, .movie],
                    onCompletion: { result in
                            
                    switch result {
                        case .success(let url):
                        if url.startAccessingSecurityScopedResource() {
                            defer { url.stopAccessingSecurityScopedResource() }
                            vm.perform(action: .userDidSelectFile(url))
                        }
                        case .failure(let error):
                        vm.handle(error)
                    }
                })
            }
        }
        .onDrop(of: [.video, .movie], delegate: vm.dropListener)
        .padding(Constants.padding)
        .ignoresSafeArea()
        .dynamicTypeSize(.large)
    }
    
}

#Preview {
    let windowSize = StartView.Constants.windowSize
    return StartView(viewModel: .init(navigator: Router(window: MainWindow(contentRect: .zero))))
        .frame(width: windowSize.width, height: windowSize.height)
}
