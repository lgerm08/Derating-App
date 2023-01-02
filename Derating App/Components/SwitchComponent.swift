//
//  SwitchComponent.swift
//  Derating App
//
//  Created by GIRA on 07/08/22.
//

import UIKit

class SwitchComponent: UIView {
    
    // MARK: - Properties
    var uiSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.onTintColor = UIColor().RGBColor(r: 50, g: 161, b: 230)
        return uiSwitch
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init(
        label: String
    ) {
        super.init(frame: .zero)
        self.label.text = label
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Configuration
  
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(uiSwitch)
        uiSwitch.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor
        )
        label.anchor(
            top: uiSwitch.topAnchor,
            left: uiSwitch.rightAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            leftConstant: 10
        )
    }
}
