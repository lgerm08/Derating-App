//
//  NavigationBar.swift
//  Derating App
//
//  Created by GIRA on 29/07/22.
//
//

import UIKit

class NavigationBar: UIView {
    
    // MARK: - Properties
    
    var backSignImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        imageView.image = UIImage(named: "backSign")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    init(
        title: String
    ) {
        super.init(frame: .zero)
        titleLabel.text = title
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Configuration

    private func setupViewLayout() {
        backgroundColor = UIColor().RGBColor(r: 35, g: 64, b: 110)
        addConstraints()
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    private func addConstraints() {
        addSubview(backSignImage)
        addSubview(titleLabel)
        backSignImage.anchor(
            left: leftAnchor,
            centerY: centerYAnchor,
            leftConstant: 16,
            widthConstant: 30
        )
        titleLabel.anchor(
            left: backSignImage.rightAnchor,
            right: rightAnchor,
            centerY: centerYAnchor,
            leftConstant: 12,
            rightConstant: 24
        )
    }
}
