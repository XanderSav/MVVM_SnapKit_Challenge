//
//  PieceView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class PieceView: UIView {
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        return stackView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Inter-Medium", size: 14)
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.required, for: .vertical)
        return textField
    }()
    
    let authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont(name: "Inter-Medium", size: 14)
        textField.borderStyle = .roundedRect
        textField.setContentHuggingPriority(.required, for: .vertical)
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.font = UIFont(name: "Inter-Medium", size: 14)
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        textView.layer.borderWidth = 1
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        initView()
        initConstraints()
    }
    
    private func initView() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(nameTextField)
        contentStackView.addArrangedSubview(authorTextField)
        contentStackView.addArrangedSubview(descriptionTextView)
    }
    
    private func initConstraints() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(topOffset: CGFloat, bottomOffset: CGFloat) {
        contentStackView.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(topOffset + Padding.insets)
            make.trailing.leading.bottom.equalToSuperview().inset(Padding.insets)
        }
    }
}
