//
//  CustomButtonView.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit
import SnapKit

class CustomButtonView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 6
        backgroundColor = UIColor(named: "ItemBackgroundColor")
        
        initView()
        initConstraints()
    }
    
    private func initView() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(iconImageView)
        contentStackView.addArrangedSubview(titleLabel)
    }
    
    private func initConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(Padding.insets)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Padding.insets)
            make.bottom.equalTo(titleLabel.snp.top)
            make.width.equalTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, iconImage: String) {
        iconImageView.image = UIImage(systemName: iconImage)
        titleLabel.text = title
    }
}
