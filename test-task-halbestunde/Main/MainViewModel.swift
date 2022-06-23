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
    
    let saveDataSubject: PublishSubject<(String, PieceModel)>
    
    init(storage: DataStorage) {
        buffer = []
        
        saveDataSubject = storage.updateListener
        
        input.addRandomPiece.asObservable().subscribe { [unowned self] _ in
            self.addRandomPiece()
        }
        .disposed(by: disposeBag)
        
        input.addNewPiece.asObservable()
            .bind(to: output.contentUnavailable)
            .disposed(by: disposeBag)
        
        storage.observableData.bind(onNext: { [unowned self] data in
            processUpdate(data)
        }).disposed(by: disposeBag)
    }
    
    private func processUpdate(_ data: [PieceModel]) {
        self.buffer = data
        
        var tmp = [PieceModel]()
        let listRef = output.pieces.value
        for item in listRef {
            if data.contains(item) {
                tmp.append(item)
            } else {
                if let i = data.firstIndex(where: ({ model in
                    model.iconName == item.iconName
                })){
                    tmp.append(data[i])
                }
            }
        }
        output.pieces.accept(tmp)
    }
    
    private func addRandomPiece() {
        let index = Int.random(in: 0 ..< buffer.count)
        let piece = buffer[index]
        let list = self.output.pieces
        
        if !list.value.contains(where: { item in
            item.name == piece.name
        }) {
            list.accept(list.value + [piece])
        } else if list.value.count == buffer.count {
            //ToDo: all available pieces already added notification
            return
        } else {
            addRandomPiece()
        }
    }
}
