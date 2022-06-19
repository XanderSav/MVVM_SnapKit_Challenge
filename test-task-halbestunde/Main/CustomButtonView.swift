//
//  CustomButtonView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class CustomButtonView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
    
        backgroundColor = .black.withAlphaComponent(0.8)
        layer.cornerRadius = 6
        
        addSubview(contentStackView)
        
        addConstraint(contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3))
        addConstraint(contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3))
        addConstraint(contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(titleLabel)
    
        contentStackView.addConstraint(iconImageView.widthAnchor.constraint(equalToConstant: 30))
        contentStackView.addConstraint(iconImageView.heightAnchor.constraint(equalToConstant: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, iconImage: String) {
        iconImageView.image = UIImage(systemName: iconImage)
        titleLabel.text = title
    }
}
