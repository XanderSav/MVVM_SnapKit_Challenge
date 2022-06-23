//
//  PieceDetailsViewModel.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 19.05.2022.
//

import Foundation

struct PieceModel: Equatable {
    let name: String
    let author: String
    let description: String
    let iconName: String
    
    init(title: String, author: String, description: String, iconName: String) {
        self.name = title
        self.author = author
        self.description = description
        self.iconName = iconName
    }
    
    static func == (lhs: PieceModel, rhs: PieceModel) -> Bool {
        return lhs.name == rhs.name &&
        lhs.author == rhs.author &&
        lhs.description == rhs.description &&
        lhs.iconName == rhs.iconName
    }
}
