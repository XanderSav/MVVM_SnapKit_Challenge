//
//  TableSection.swift
//  test-task-halbestunde
//
//  Created by Alexander Savchenko on 21.06.2022.
//

import Foundation
import RxDataSources

struct TableSection {
  var items: [PieceModel]
}

extension TableSection: SectionModelType {
  init(original: TableSection, items: [PieceModel]) {
    self = original
    self.items = items
  }
}
