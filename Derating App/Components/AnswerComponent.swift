
import UIKit

class AnswerComponent: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        return label
    }()
    
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    init(
        label: String,
        unit: String
    ) {
        super.init(frame: .zero)
        self.label.text = label
        self.unitLabel.text = unit
        setupViewLayout()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Configuration
    func setResult(result: Float) {
        resultLabel.text = String(result)
    }
    
    private func setupViewLayout() {
        backgroundColor = .clear
    }
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(resultLabel)
        addSubview(unitLabel)
        label.anchor(
            left: leftAnchor,
            leftConstant: 5,
            widthConstant: 50
        )
        resultLabel.anchor(
            left: label.rightAnchor,
            leftConstant: 5
        )
        unitLabel.anchor(
            left: resultLabel.rightAnchor,
            right: rightAnchor,
            leftConstant: 5,
            rightConstant: 15
        )
    }
}
