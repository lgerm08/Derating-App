
import UIKit

class TextFieldComponent: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.keyboardType = .numberPad
        textField.layer.cornerRadius = 15.0
        textField.keyboardType = .numbersAndPunctuation
        textField.isEnabled = true
        textField.addPadding(.both(10))
        return textField
    }()
    
    init(
        label: String
    ) {
        super.init(frame: .zero)
        self.label.text = label
        textField.delegate = self
        setupViewLayout()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Configuration
    
    private func setupViewLayout() {
        backgroundColor = .clear
    }
    
    func asFloat() -> Float? {
        if let value = Float(self.textField.text ?? "") {
            return value
        } else {
            return nil
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                } else {
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(textField)
        label.anchor(
            centerX: centerXAnchor
        )
        textField.anchor(
            top: label.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            centerX: label.centerXAnchor,
            topConstant: 15,
            heightConstant: 40
        )
    }
}
