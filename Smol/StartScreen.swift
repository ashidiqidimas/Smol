//
//  StartScreen.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import SwiftUI

struct StartView: View {
    
    @ObservedObject private var vm: StartScreenViewModel
    
    init(viewModel: StartScreenViewModel) {
        self._vm = ObservedObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.clear)
                .stroke(
                    Color(nsColor: NSColor.tertiaryLabelColor),
                    style: .init(lineWidth: 3,lineCap: .round, dash: [12])
                )
            
            VStack(spacing: 16) {
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
                        vm.perform(action: .userDidSelectFile(url))
                        case .failure(let error):
                        vm.handle(error)
                    }
                })
            }
        }
        .padding(EdgeInsets(top: 48, leading: 40, bottom: 40, trailing: 40))
        .ignoresSafeArea()
        .dynamicTypeSize(.large)
    }
    
}

#Preview {
    StartView(viewModel: .init(navigator: Router(window: MainWindow(contentRect: .zero))))
        .frame(width: 300, height: 240)
}
