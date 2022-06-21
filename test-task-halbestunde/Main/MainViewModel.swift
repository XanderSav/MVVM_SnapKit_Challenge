//
//  MainViewModel.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    private var disposeBag = DisposeBag()
    private var buffer = [PieceModel]()
    
    struct Input {
        let addRandomPiece = PublishRelay<UITapGestureRecognizer>()
        let addNewPiece = PublishRelay<UITapGestureRecognizer>()
    }
    struct Output {
        let pieces = BehaviorRelay<[PieceModel]>(value: [])
        let contentUnavailable = PublishRelay<UITapGestureRecognizer>()
    }
    
    let input = Input()
    let output = Output()
    
    init(storage: DataStorage) {
        buffer = storage.getData()
        
        input.addRandomPiece.asObservable().subscribe { [weak self] _ in
            if let strongSelf = self {
                strongSelf.addRandomPiece()
            }
        }
        .disposed(by: disposeBag)
        
        input.addNewPiece.asObservable()
            .bind(to: output.contentUnavailable)
            .disposed(by: disposeBag)
    }
    
    private func addRandomPiece() {
        let index = Int.random(in: 0 ..< buffer.count)
        let piece = buffer[index]
        let list = self.output.pieces
        
        if !list.value.contains(where: { item in
            item.name == piece.name
        }) {
            list.accept(list.value + [piece])
        }
    }
}
