
import UIKit

class AnswerComponent: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 75
        view.layer.borderColor = UIColor().RGBColor(r: 50, g: 161, b: 230).cgColor
        view.layer.borderWidth = 10
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.text = ""
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var unitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    init(
    ) {
        super.init(frame: .zero)
        setupViewLayout()
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabels(label: String, value: Double, unit: String) {
        self.label.text = label
        self.resultLabel.text = String(format: "%.4f", value)
        self.unitLabel.text = unit
    }
    
    // MARK: - Layout Configuration
    
    private func setupViewLayout() {
        backgroundColor = .clear
    }
    
    private func setupSubviews() {
        addSubview(label)
        addSubview(circleView)
        circleView.addSubview(resultLabel)
        circleView.addSubview(unitLabel)
        label.anchor(
            top: topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            leftConstant: 12,
            rightConstant: 12
        )
        circleView.anchor(
            top: label.bottomAnchor,
            centerX: label.centerXAnchor,
            topConstant: 15,
            widthConstant: 150,
            heightConstant: 150
        )
        resultLabel.anchor(
            top: circleView.topAnchor,
            centerX: circleView.centerXAnchor,
            topConstant: 50,
            widthConstant: 100
        )
        unitLabel.anchor(
            top: resultLabel.bottomAnchor,
            centerX: resultLabel.centerXAnchor,
            topConstant: 8,
            widthConstant: 100
        )
    }
}
