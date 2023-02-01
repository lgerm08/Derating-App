//
//  HarmonicCurrentViewCell.swift
//  Derating App
//
//  Created by GIRA on 15/12/22.
//

import UIKit

protocol HarmonicCurrentViewCellProtocol {
    func currentValueDidChange(indexPath: Int, stringValue: String?)
    func orderValueDidChange(indexPath: Int, stringValue: String?)
    func deleteCell(indexPath: Int)
}

class HarmonicCurrentViewCell: UITableViewCell, UITextFieldDelegate {

    var orderTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor().RGBColor(r: 230, g: 238, b: 242)
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15.0
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        textField.addPadding(.both(10))
        textField.placeholder = "Ordem"
        return textField
    }()
    
    var currentTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor().RGBColor(r: 230, g: 238, b: 242)
        textField.layer.cornerRadius = 15.0
        textField.keyboardType = .numbersAndPunctuation
        textField.isEnabled = true
        textField.isUserInteractionEnabled = true
        textField.addPadding(.both(10))
        return textField
    }()
    
    var trashIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "trash-can")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var delegate: HarmonicCurrentViewCellProtocol?
    var indexPath: Int = 0
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        currentTextField.addTarget(self, action: #selector(self.currentValueDidChange(_:)), for: .editingChanged)
        currentTextField.delegate = self
        orderTextField.addTarget(self, action: #selector(self.orderValueDidChange(_:)), for: .editingChanged)
        orderTextField.delegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.deleteCell))
        gesture.cancelsTouchesInView = false
        trashIcon.addGestureRecognizer(gesture)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitleAndUnit(order: String?, current: String?, unit: String, index: Int, delegate: HarmonicCurrentViewCellProtocol) {
        orderTextField.text = order
        currentTextField.placeholder = "Corrente " + unit
        currentTextField.text = current
        indexPath = index
        self.delegate = delegate
    }
    
    func disableEditing() {
        orderTextField.isUserInteractionEnabled = false
        currentTextField.isUserInteractionEnabled = false
        trashIcon.isHidden = true
        orderTextField.backgroundColor = .lightGray
        currentTextField.backgroundColor = .lightGray
    }
    
    @objc func currentValueDidChange(_ textField: UITextField) {
        currentTextField.formatAsDecimal()
        delegate?.currentValueDidChange(indexPath: indexPath, stringValue: textField.text)
    }
    
    @objc func orderValueDidChange(_ textField: UITextField) {
        currentTextField.formatAsDecimal()
        delegate?.orderValueDidChange(indexPath: indexPath, stringValue: textField.text)
    }
    
    @objc func deleteCell(sender: UITapGestureRecognizer) {
        delegate?.deleteCell(indexPath: indexPath)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == orderTextField {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            return string.rangeOfCharacter(from: invalidCharacters) == nil
        }
        return true
    }
    
    // MARK: - Setup Layout
    private func setupSubviews() {
        addSubview(orderTextField)
        addSubview(currentTextField)
        addSubview(trashIcon)
        orderTextField.anchor(
            top: topAnchor,
            left: leftAnchor,
            topConstant: 10,
            leftConstant: 10,
            widthConstant: 100,
            heightConstant: 50
        )
        currentTextField.anchor(
            top: orderTextField.topAnchor,
            left: orderTextField.rightAnchor,
            leftConstant: 10,
            heightConstant: 50
        )
        trashIcon.anchor(
            left: currentTextField.rightAnchor,
            right: rightAnchor,
            centerY: currentTextField.centerYAnchor,
            leftConstant: 5,
            rightConstant: 10,
            widthConstant: 30,
            heightConstant: 30
        )
    }
}
