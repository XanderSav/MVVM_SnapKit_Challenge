//
//  MainView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        return stackView
    }()
    
    let newPieceView: CustomButtonView = {
        let view = CustomButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(title: "Add new piece", iconImage: "plus")
        return view
    }()
    
    let randomPieceView: CustomButtonView = {
        let view = CustomButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(title: "Add random piece", iconImage: "questionmark")
        return view
    }()
    
    private let spacing: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let piecesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        initView()
        initConstraints()
    }
    
    private func initView() {
        addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(newPieceView)
        buttonsStackView.addArrangedSubview(spacing)
        buttonsStackView.addArrangedSubview(randomPieceView)
        addSubview(piecesTableView)
    }
    
    private func initConstraints() {
        buttonsStackView.snp.makeConstraints { make in
            make.width.equalToSuperview().inset(Padding.insets)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
        }
        newPieceView.snp.makeConstraints {make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(spacing.snp.leading)
        }
        spacing.snp.makeConstraints {make in
            make.width.equalTo(Padding.spacing)
            make.centerX.equalToSuperview()
            make.trailing.equalTo(randomPieceView.snp.leading)
        }
        randomPieceView.snp.makeConstraints {make in
            make.trailing.equalToSuperview()
        }
        piecesTableView.snp.makeConstraints {make in
            make.width.equalToSuperview().inset(Padding.insets)
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonsStackView.snp.bottom).offset(Padding.insets)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(topOffset: CGFloat, bottomOffset: CGFloat) {
        buttonsStackView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(topOffset)
        }
        
        piecesTableView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(bottomOffset)
        }
    }
}
