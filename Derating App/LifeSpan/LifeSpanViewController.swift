//
//  LifeSpanViewController.swift
//  Derating App
//
//  Created by GIRA on 06/07/22.
//

import UIKit

class LifeSpanViewController: UIViewController {
    
    let viewModel = LifeSpanViewModel()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Estimativa de Vida Útil do Transformador"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var PJ1TextField: TextFieldComponent = {
        let textField = TextFieldComponent(label: "PJ1")
        return textField
    }()
    
    private lazy var temperatureTextField: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Temperatura Máxima do Enrolamento [K]")
        return textField
    }()
    
    private lazy var NBR5416Button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("NBR 5416", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(estimateWithNBR5416), for: .touchUpInside)
        return button
    }()
    
    private lazy var ANSIC5791Button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("ANSI C57.91", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(estimateWithANSIC5791), for: .touchUpInside)
        return button
    }()
    
    private lazy var PECOButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("PECO", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(estimateWithPECO), for: .touchUpInside)
        return button
    }()
    
    private lazy var MONTSINGERButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("MONTSINGER", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(estimateWithMontSinger), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    private lazy var estimatedLifeSpan: AnswerComponent = {
        let answer = AnswerComponent(label: "EV", unit: "[horas]")
        answer.isHidden = true
        return answer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    @objc func estimateWithNBR5416() {
        if let theta = asFloat(temperatureTextField) {
            viewModel.estimateWithNBR5416(tempeture: theta)
            estimatedLifeSpan.setResult(result: viewModel.estimatedLifeSpan)
            estimatedLifeSpan.isHidden = false
        }
    }
    
    @objc func estimateWithANSIC5791() {
        if let theta = asFloat(temperatureTextField) {
            viewModel.estimateWithANSIC5791(tempeture: theta)
            estimatedLifeSpan.setResult(result: viewModel.estimatedLifeSpan)
            estimatedLifeSpan.isHidden = false
        }
    }
    @objc func estimateWithPECO() {
        if let theta = asFloat(temperatureTextField) {
            viewModel.estimateWithPECO(tempeture: theta)
            estimatedLifeSpan.setResult(result: viewModel.estimatedLifeSpan)
            estimatedLifeSpan.isHidden = false
        }
    }
    
    @objc func estimateWithMontSinger() {
//        if let theta = asFloat(temperatureTextField) {
//            viewModel.estimateWithMontSinger(tempeture: theta)
//            estimatedLifeSpan.setResult(result: viewModel.estimatedLifeSpan)
//            estimatedLifeSpan.isHidden = false
//        }
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor().RGBColor(r: 68, g: 127, b: 166)
        view.addSubview(titleLabel)
        view.addSubview(temperatureTextField)
        view.addSubview(NBR5416Button)
        view.addSubview(ANSIC5791Button)
        view.addSubview(PECOButton)
        view.addSubview(MONTSINGERButton)
        view.addSubview(estimatedLifeSpan)
        addConstraints()
    }
    
    func asFloat(_ textNumber: TextFieldComponent) -> Float? {
        if let value = Float(textNumber.textField.text ?? "") {
            return value
        } else {
            return nil
        }
    }
    
    func addConstraints() {
        titleLabel.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 60,
            leftConstant: 30,
            rightConstant: 30
        )
        temperatureTextField.anchor(
            top: titleLabel.bottomAnchor,
            left: titleLabel.leftAnchor,
            right: titleLabel.rightAnchor,
            topConstant: 30,
            heightConstant: 65
        )
        NBR5416Button.anchor(
            top: temperatureTextField.bottomAnchor,
            left: titleLabel.leftAnchor,
            right: titleLabel.rightAnchor,
            topConstant: 40,
            heightConstant: 60
        )
        ANSIC5791Button.anchor(
            top: NBR5416Button.bottomAnchor,
            left: NBR5416Button.leftAnchor,
            right: NBR5416Button.rightAnchor,
            topConstant: 40,
            heightConstant: 60
        )
       PECOButton.anchor(
            top: ANSIC5791Button.bottomAnchor,
            left: NBR5416Button.leftAnchor,
            right: NBR5416Button.rightAnchor,
            topConstant: 40,
            heightConstant: 60
        )
        MONTSINGERButton.anchor(
            top: PECOButton.bottomAnchor,
            left: NBR5416Button.leftAnchor,
            right: NBR5416Button.rightAnchor,
            topConstant: 40,
            heightConstant: 60
        )
        estimatedLifeSpan.anchor(
            top: MONTSINGERButton.bottomAnchor,
            left: NBR5416Button.leftAnchor,
            right: NBR5416Button.rightAnchor,
            topConstant: 40,
            heightConstant: 60
        )
        
    }
}
