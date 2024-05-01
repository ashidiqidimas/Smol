//
//  StartScreenViewModel.swift
//  Smol
//
//  Created by Dimas on 01/05/24.
//

import Foundation

class StartScreenViewModel: ObservableObject {
    
    private let navigator: StartScreenRouterProtocol
    
    init(navigator: StartScreenRouterProtocol) {
        self.navigator = navigator
    }
    
    enum Action {
        case userDidTapImportButton
        case userDidSelectFile(URL)
    }
    
    @Published var isImporting = false
    
    func perform(action: Action) {
        switch action {
        case .userDidTapImportButton:
            isImporting = true
        case .userDidSelectFile(let url):
            isImporting = false
            navigator.routeToEditor(with: url)
        }
    }
    
    func handle(_ error: Error) {
        fatalError(error.localizedDescription)
    }
    
}
