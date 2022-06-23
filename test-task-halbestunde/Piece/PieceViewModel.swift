//
//  PieceViewModel.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import Foundation
import RxSwift
import RxRelay

class PieceViewModel {
    let name: String
    let author: String
    let description: String
    let posterName: String
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let name = PublishRelay<String>()
        let author = PublishRelay<String>()
        let description = PublishRelay<String>()
    }
    
    struct Output {
        let save = PublishRelay<Void>()
    }
    
    let input = Input()
    let output = Output()
    
    init(model: PieceModel, saveSubject: PublishSubject<(String, PieceModel)>) {
        name = model.name
        author = model.author
        description = model.description
        posterName = model.iconName
        
        bind(sub: saveSubject)
    }
    
    func bind(sub: PublishSubject<(String, PieceModel)>) {
        let changedModel = Observable.combineLatest(input.name, input.author, input.description)
            .map({ name, author, description -> PieceModel in
                return PieceModel(title: name, author: author, description: description, iconName: self.posterName)
            })
        
        output.save
            .withLatestFrom(changedModel)
            .map({ model in
                return (self.name, model)
            })
            .bind(to: sub)
            .disposed(by: disposeBag)
    }
}
