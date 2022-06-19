//
//  MainView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

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
    
    private var contentTopOffsetConstraint = NSLayoutConstraint()
    private var contentBottomOffsetConstraint = NSLayoutConstraint()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(buttonsStackView)
        
        contentTopOffsetConstraint = buttonsStackView.topAnchor.constraint(equalTo: topAnchor)
        addConstraint(contentTopOffsetConstraint)
        addConstraint(buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20))
        addConstraint(buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20))
        addConstraint(buttonsStackView.heightAnchor.constraint(equalToConstant: 100))
        
        buttonsStackView.addArrangedSubview(newPieceView)
        buttonsStackView.addArrangedSubview(spacing)
        buttonsStackView.addArrangedSubview(randomPieceView)
        
        buttonsStackView.addConstraint(spacing.widthAnchor.constraint(equalToConstant: 10))
        
        addSubview(piecesTableView)
        
        addConstraint(piecesTableView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: -20))
        addConstraint(piecesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20))
        addConstraint(piecesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20))
        addConstraint(piecesTableView.bottomAnchor.constraint(equalTo: bottomAnchor))
        
        layoutSubviewsClosure = { [weak self] in
            guard let self = self else { return }
            let width = self.buttonsStackView.frame.size.width
            let widthButton = (width - self.spacing.frame.size.width) / 2
            
            self.buttonsStackView.addConstraint(self.newPieceView.widthAnchor.constraint(equalToConstant: widthButton))
            self.buttonsStackView.addConstraint(self.randomPieceView.widthAnchor.constraint(equalToConstant: widthButton))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var layoutSubviewsClosure: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSubviewsClosure?()
    }
    
    func update(topOffset: CGFloat) {
        let bottomOffset: CGFloat = 50
        
        contentTopOffsetConstraint.constant = topOffset
        contentBottomOffsetConstraint.constant = bottomOffset
    }
}
