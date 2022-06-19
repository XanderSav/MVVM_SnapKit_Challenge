//
//  PieceCell.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class PieceCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pieceInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 3
        return stackView
    }()
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        return stackView
    }()
    
    private let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        contentView.addSubview(bgView)
        
        contentView.addConstraint(bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor))
        contentView.addConstraint(bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor))
        contentView.addConstraint(bgView.topAnchor.constraint(equalTo: contentView.topAnchor))
        contentView.addConstraint(bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor))
        
        contentView.addSubview(contentStackView)
        
        contentView.addConstraint(contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12))
        contentView.addConstraint(contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12))
//        contentView.addConstraint(contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12))
//        contentView.addConstraint(contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12))
        
        contentView.addConstraint(contentStackView.heightAnchor.constraint(equalToConstant: 280))
        contentView.addConstraint(contentStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        headerStackView.addArrangedSubview(iconImageView)
        headerStackView.addArrangedSubview(pieceInfoStack)
        
        iconImageView.addConstraint(iconImageView.heightAnchor.constraint(equalToConstant: 50))
        iconImageView.addConstraint(iconImageView.widthAnchor.constraint(equalToConstant: 50))
        
        pieceInfoStack.addArrangedSubview(nameLabel)
        pieceInfoStack.addArrangedSubview(authorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: PieceDetailsViewModel) {
        nameLabel.text = viewModel.name
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        iconImageView.image = UIImage(named: viewModel.iconName)
    }
}
