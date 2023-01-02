//
//  DeratingViewController.swift
//  Derating App
//
//  Created by GIRA on 30/06/22.
//

import UIKit

class DeratingHomeViewController: UIViewController {
    
    let viewModel = DeratingViewModel()
    
    private lazy var navbar: NavigationBar = {
       let navBar = NavigationBar(title: "Informações disponíveis")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var ratedCondition: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Opera em condições nominais")
        return uiSwitch
    }()
    
    
    private lazy var puJouleLosses: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Perdas Joules pu na base RIˆ2")
        return uiSwitch
    }()
    
    private lazy var wattsJouleLosses: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Perdas Joules em watts")
        return uiSwitch
    }()
    
    private lazy var transformerData: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Dados de Placa")
        return uiSwitch
    }()
    
    private lazy var rPercent: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Resistência percentual (R%)")
        return uiSwitch
    }()
    
    private lazy var puTestData: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Dados de Ensaio de Curto-Circuito [pu]")
        return uiSwitch
    }()
    
    private lazy var siTestData: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Dados de Ensaio de Curto-Circuito [SI]")
        return uiSwitch
    }()
    
    private lazy var puHarmonicCurrent: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "I harmônicas [pu]")
        return uiSwitch
    }()
    
    private lazy var amperHarmonicCurrent: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "I harmônicas [A]")
        return uiSwitch
    }()
    
    private lazy var amperMeasuredCurrent: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "I dos enrolamentos em F fundamental [A]")
        return uiSwitch
    }()
    
    private lazy var harmonicFactor: SwitchComponent = {
        let uiSwitch = SwitchComponent(label: "Fator de Distorção Harmônica (FHL)")
        return uiSwitch
    }()
    
    private lazy var nextButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Próximo")
        buttonView.button.addTarget(self, action: #selector(routeToNextView), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var unselectAll: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Desmarcar todos")
        buttonView.button.addTarget(self, action: #selector(unselectAllSwitchs), for: .touchUpInside)
        return buttonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    @objc func unselectAllSwitchs() {
        ratedCondition.uiSwitch.setOn(false, animated: true)
        puJouleLosses.uiSwitch.setOn(false, animated: true)
        wattsJouleLosses.uiSwitch.setOn(false, animated: true)
        transformerData.uiSwitch.setOn(false, animated: true)
        rPercent.uiSwitch.setOn(false, animated: true)
        puTestData.uiSwitch.setOn(false, animated: true)
        siTestData.uiSwitch.setOn(false, animated: true)
        puHarmonicCurrent.uiSwitch.setOn(false, animated: true)
        amperHarmonicCurrent.uiSwitch.setOn(false, animated: true)
        amperMeasuredCurrent.uiSwitch.setOn(false, animated: true)
        harmonicFactor.uiSwitch.setOn(false, animated: true)
    }
    
    @objc func routeToNextView() {
        let availableData = AvailableData(
            isInRatedCondition: ratedCondition.uiSwitch.isOn,
            hasPuJouleLosses: puJouleLosses.uiSwitch.isOn,
            hasWattsJouleLosses: wattsJouleLosses.uiSwitch.isOn,
            hasRPercent: rPercent.uiSwitch.isOn,
            hasPuTestData: puTestData.uiSwitch.isOn,
            hasSiTestData: siTestData.uiSwitch.isOn,
            hasTransformerData: transformerData.uiSwitch.isOn,
            hasPuHarmonicCurrent: puHarmonicCurrent.uiSwitch.isOn,
            hasAmperHarmonicCurrent: amperHarmonicCurrent.uiSwitch.isOn,
            amperMeasuredCurrent: amperMeasuredCurrent.uiSwitch.isOn,
            hasHarmonicFactor: harmonicFactor.uiSwitch.isOn
        )
        if availableData.hasEnoughData() {
            let newViewController = InputDataViewController(viewModel: InputDataViewModel(availableData: availableData))
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        } else {
            let action = UIAlertAction(title: "OK", style: .default)
            let alert = UIAlertController(title: "Dados Insuficientes", message: "Não é possível calcular a corrente de derating com apenas esses dados", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(navbar)
        view.addSubview(scrollView)
        view.addSubview(nextButton)
        addConstraints()
    }
    
    func addConstraints() {
        navbar.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 120
        )
        scrollView.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            bottom: nextButton.topAnchor,
            right: view.rightAnchor,
            topConstant: 15
        )
        nextButton.anchor(
            bottom: view.bottomAnchor,
            centerX: view.centerXAnchor,
            bottomConstant: 40,
            widthConstant: 130,
            heightConstant: 80
        )
        setScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1200)
    }
    
    func setScrollView() {
        scrollView.addSubview(ratedCondition)
        scrollView.addSubview(puJouleLosses)
        scrollView.addSubview(wattsJouleLosses)
        scrollView.addSubview(transformerData)
        scrollView.addSubview(rPercent)
        scrollView.addSubview(puTestData)
        scrollView.addSubview(siTestData)
        scrollView.addSubview(puHarmonicCurrent)
        scrollView.addSubview(amperHarmonicCurrent)
        scrollView.addSubview(amperMeasuredCurrent)
        scrollView.addSubview(harmonicFactor)
        scrollView.addSubview(unselectAll)
        scrollView.isScrollEnabled = true
        
        unselectAll.anchor(
            top: scrollView.topAnchor,
            left: ratedCondition.leftAnchor,
            topConstant: 20,
            widthConstant: 200,
            heightConstant: 60
        )
        ratedCondition.anchor(
            top: unselectAll.bottomAnchor,
            left: scrollView.leftAnchor,
            right: scrollView.rightAnchor,
            topConstant: 20,
            leftConstant: 20,
            rightConstant: 20,
            heightConstant: 35
        )
        puJouleLosses.anchor(
            top: ratedCondition.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        wattsJouleLosses.anchor(
            top: puJouleLosses.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        transformerData.anchor(
            top: wattsJouleLosses.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        rPercent.anchor(
            top: transformerData.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        puTestData.anchor(
            top: rPercent.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        siTestData.anchor(
            top: puTestData.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        puHarmonicCurrent.anchor(
            top: siTestData.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        amperHarmonicCurrent.anchor(
            top: puHarmonicCurrent.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        amperMeasuredCurrent.anchor(
            top: amperHarmonicCurrent.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
        harmonicFactor.anchor(
            top: amperMeasuredCurrent.bottomAnchor,
            left: ratedCondition.leftAnchor,
            right: ratedCondition.rightAnchor,
            topConstant: 20,
            heightConstant: 35
        )
    }
}
