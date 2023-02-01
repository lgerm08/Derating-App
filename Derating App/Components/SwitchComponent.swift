//
//  SwitchComponent.swift
//  Derating App
//
//  Created by GIRA on 07/08/22.
//

import UIKit

protocol SwitchComponentProtocol {
    func switchChangedValue(switchName: String)
}

class SwitchComponent: UITableViewCell {
    
    // MARK: - Properties
    var uiSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.isOn = false
        uiSwitch.onTintColor = UIColor().RGBColor(r: 50, g: 161, b: 230)
        uiSwitch.addTarget(nil, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        uiSwitch.isUserInteractionEnabled = true
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
    
    var delegate: SwitchComponentProtocol?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(label: String, status: Bool) {
        self.label.text = label
        self.uiSwitch.isOn = status
    }
    
    @objc func switchChanged(mySwitch: UISwitch) {
        if let switchName = label.text {
            delegate?.switchChangedValue(switchName: switchName)
        }
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
            right: rightAnchor,
            topConstant: 10,
            leftConstant: 10
        )
    }
}
