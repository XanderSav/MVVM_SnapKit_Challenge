//
//  PieceViewModel.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import Foundation

class PieceViewModel {
    let name: String
    let author: String
    let description: String
    let posterName: String
    
    private let saveHandle: ((PieceDetailsViewModel) -> Void)
    
    init(viewModel: PieceDetailsViewModel, saveHandle: @escaping ((PieceDetailsViewModel) -> Void)) {
        name = viewModel.name
        author = viewModel.author
        description = viewModel.description
        posterName = viewModel.iconName
        self.saveHandle = saveHandle
    }
    
    func save(title: String, author: String, description: String) {
        saveHandle(PieceDetailsViewModel(title: title, author: author, description: description, iconName: posterName))
    }
}
