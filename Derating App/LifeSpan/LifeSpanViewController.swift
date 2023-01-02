//
//  LifeSpanViewController.swift
//  Derating App
//
//  Created by GIRA on 06/07/22.
//

import UIKit

class LifeSpanViewController: UIViewController {
    
    let viewModel = LifeSpanViewModel()

    private lazy var navbar: NavigationBar = {
       let navBar = NavigationBar(title: "Estimativa de Vida Útil do Transformador")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var PJ1TextField: UITextField = {
        let textField = UITextField()
        textField.text = "PJ [W]"
        return textField
    }()
    
    private lazy var temperatureTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Temperatura Máxima do Enrolamento [K]"
        return textField
    }()
    
    private lazy var NBR5416Button: ButtonComponent = {
        let buttonView = ButtonComponent(title: "NBR 5416")
        buttonView.button.addTarget(self, action: #selector(estimateWithNBR5416), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var ANSIC5791Button: ButtonComponent = {
        let buttonView = ButtonComponent(title: "ANSI C57.91")
        buttonView.button.addTarget(self, action: #selector(estimateWithANSIC5791), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var PECOButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "PECO")
        buttonView.button.addTarget(self, action: #selector(estimateWithPECO), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var MONTSINGERButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "MONTSINGER")
        buttonView.button.addTarget(self, action: #selector(estimateWithMontSinger), for: .touchUpInside)
        buttonView.button.isEnabled = false
        return buttonView
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
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func estimateWithMontSinger() {
//        if let theta = asFloat(temperatureTextField) {
//            viewModel.estimateWithMontSinger(tempeture: theta)
//            estimatedLifeSpan.setResult(result: viewModel.estimatedLifeSpan)
//            estimatedLifeSpan.isHidden = false
//        }
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(navbar)
        view.addSubview(temperatureTextField)
        view.addSubview(NBR5416Button)
        view.addSubview(ANSIC5791Button)
        view.addSubview(PECOButton)
        view.addSubview(MONTSINGERButton)
        view.addSubview(estimatedLifeSpan)
        addConstraints()
    }
    
    func asFloat(_ textNumber: UITextField) -> Float? {
        if let value = Float(textNumber.text ?? "") {
            return value
        } else {
            return nil
        }
    }
    
    func addConstraints() {
        navbar.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 120
        )
        temperatureTextField.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 30,
            leftConstant: 30,
            rightConstant: 30,
            heightConstant: 65
        )
        NBR5416Button.anchor(
            top: temperatureTextField.bottomAnchor,
            left: temperatureTextField.leftAnchor,
            right: temperatureTextField.rightAnchor,
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
