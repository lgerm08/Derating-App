//
//  ButtonComponent.swift
//  Derating App
//
//  Created by GIRA on 07/08/22.
//

import UIKit

class ButtonComponent: UIView {
    var button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 50, g: 161, b: 230)
        button.tintColor = .white
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        return button
    }()
    
    init(
        title: String
    ) {
        super.init(frame: .zero)
        self.button.setTitle(title, for: .normal)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(button)
        button.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }
}
