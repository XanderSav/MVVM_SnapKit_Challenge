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
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let authorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        return textView
    }()
    
    init() {
        super.init(frame: .zero)
        
        addSubview(contentStackView)
        
        addConstraint(contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor))
        addConstraint(contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor))
        addConstraint(contentStackView.topAnchor.constraint(equalTo: topAnchor))
        addConstraint(contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor))
        
        contentStackView.addArrangedSubview(posterImageView)
        
        posterImageView.addConstraint(posterImageView.widthAnchor.constraint(equalToConstant: 100))
        posterImageView.addConstraint(posterImageView.heightAnchor.constraint(equalToConstant: 200))
        
        contentStackView.addArrangedSubview(nameTextField)
        contentStackView.addArrangedSubview(authorTextField)
        contentStackView.addArrangedSubview(descriptionTextView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
