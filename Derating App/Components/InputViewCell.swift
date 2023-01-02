//
//  InputViewCell.swift
//  Derating App
//
//  Created by GIRA on 09/08/22.
//

import UIKit

protocol InputViewCellProtocol {
    func areaTextFieldDidChange(indexPath: Int, stringValue: String?)
}

class InputViewCell: UITableViewCell {

    var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor().RGBColor(r: 230, g: 238, b: 242)
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15.0
        textField.keyboardType = .numbersAndPunctuation
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        textField.addPadding(.both(10))
        return textField
    }()
    
    var unitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var delegate: InputViewCellProtocol?
    var indexPath: Int = 0
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        textField.addTarget(self, action: #selector(self.areaTextFieldDidChange(_:)), for: .editingChanged)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleAndUnit(title: String, unit: String, index: Int) {
        textField.placeholder = title
        unitLabel.text = unit
        indexPath = index
    }
    
    @objc func areaTextFieldDidChange(_ textField: UITextField) {
        textField.formatAsDecimal()
        delegate?.areaTextFieldDidChange(indexPath: indexPath, stringValue: textField.text)
    }
    
    // MARK: - Setup Layout
    private func setupSubviews() {
        addSubview(textField)
        addSubview(unitLabel)
        bringSubviewToFront(textField)
        textField.anchor(
            top: topAnchor,
            left: leftAnchor,
            topConstant: 20,
            leftConstant: 10,
            heightConstant: 50
        )
        unitLabel.anchor(
            left: textField.rightAnchor,
            right: rightAnchor,
            centerY: textField.centerYAnchor,
            leftConstant: 4,
            widthConstant: 30
        )
    }
}
