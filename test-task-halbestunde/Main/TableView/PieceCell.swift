//
//  PieceCell.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class PieceCell: UITableViewCell {
    
    private let bgView: UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor(named: "ItemBackgroundColor")
        bg.layer.cornerRadius = 6
        return bg
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pieceInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)

        initView()
        initConstraints()
    }
    
    private func initView() {
        contentView.addSubview(bgView)
        
        bgView.addSubview(contentStackView)
        contentStackView.addArrangedSubview(headerStackView)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        headerStackView.addArrangedSubview(iconImageView)
        headerStackView.addArrangedSubview(pieceInfoStack)
        
        pieceInfoStack.addArrangedSubview(nameLabel)
        pieceInfoStack.addArrangedSubview(authorLabel)
    }
    
    private func initConstraints() {
        bgView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Padding.insets)
        }
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Padding.insets)
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        pieceInfoStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
        }
        headerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: PieceModel) {
        nameLabel.text = viewModel.name
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        iconImageView.image = UIImage(named: viewModel.iconName)
    }
}
