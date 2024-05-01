//
//  StartScreen.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import SwiftUI

struct StartView: View {
    
    @State var isImporting = false
    
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
                    isImporting = true
                } label: {
                    Text("Select a File")
                        .font(.system(.title3, design: .rounded))
                        .padding(.horizontal, 12)
                        .frame(height: 36)
                        .background(.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
                .fileImporter(isPresented: $isImporting,
                              allowedContentTypes: [.video, .movie],
                    onCompletion: { result in
                            
                    switch result {
                        case .success(let url):
                        handle(url)
                        case .failure(let error):
                            print(error)
                    }
                })
            }
        }
        .padding(EdgeInsets(top: 48, leading: 40, bottom: 40, trailing: 40))
        .ignoresSafeArea()
        .dynamicTypeSize(.large)
    }
    
    func handle(_ url: URL) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            guard let window = NSApplication.shared.mainWindow else { return }
            
            window.setSizeWithAnimation(to: CGSize(width: 800, height: 600))
            window.styleMask.insert(.resizable)
        }
    }
    
}

extension NSWindow {
    

    
}

extension NSPoint {
    
 
    
}

#Preview {
    StartView()
        .frame(width: 300, height: 240)
}
