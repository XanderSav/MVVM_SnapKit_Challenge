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
    
    //private var saveHandle: ((PieceModel) -> Void)
    
    init(viewModel: PieceModel) {//, saveHandle: @escaping ((PieceModel) -> Void)) {
        name = viewModel.name
        author = viewModel.author
        description = viewModel.description
        posterName = viewModel.iconName
        //self.saveHandle = saveHandle
    }
    
    func save(title: String, author: String, description: String) {
        //saveHandle(PieceModel(title: title, author: author, description: description, iconName: posterName))
    }
}
