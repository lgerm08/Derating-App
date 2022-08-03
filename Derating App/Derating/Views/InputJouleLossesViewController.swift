//
//  InputJouleLossesViewController.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import UIKit

class InputJouleLossesViewController: UIViewController {
    
    var viewModel = DeratingViewModel()
    
    var selectedOption = ""
    
    private lazy var navBar: NavigationBar = {
        let navBar = NavigationBar(title: "Preencha o(s) campo(s) abaixo")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var r1: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Resistência do Primário")
        return textField
    }()
    
    private lazy var i1: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Corrente do Primário")
        return textField
    }()
    
    private lazy var r2: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Resistência do Secundário")
        return textField
    }()
    
    private lazy var i2: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Corrente do Secundário")
        return textField
    }()
    
    private lazy var zPercent: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Impedância Percentual")
        return textField
    }()
    
    private lazy var jouleLosses: TextFieldComponent = {
        let textField = TextFieldComponent(label: "Perdas Joulicas")
        return textField
    }()
    
    private lazy var routeToNextScreen: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Próximo", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(routeToEddyCurrentLosses), for: .touchUpInside)
        return button
    }()
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func routeToEddyCurrentLosses(sender: UITapGestureRecognizer) {
        let newViewController = EddyCurrentLossViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.jouleLosses = viewModel.getJouleLosses()
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    func setViews() {
        view.backgroundColor = UIColor().RGBColor(r: 45, g: 111, b: 158)
        view.addSubview(navBar)
        navBar.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 120
        )
        switch selectedOption {
        case .zPercent:
            setViewForZPercent()
        case .transformerTests:
            setViewForTestData()
        case .jouleLosses:
            setViewForJouleLosses()
        default:
            return
        }
    }
    
    func setViewForZPercent() {
        view.addSubview(zPercent)
        view.addSubview(routeToNextScreen)
        zPercent.anchor(
            top: navBar.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 40,
            leftConstant: 24,
            rightConstant: 24,
            heightConstant: 60
        )
        routeToNextScreen.anchor(
            top: zPercent.bottomAnchor,
            left: zPercent.leftAnchor,
            right: zPercent.rightAnchor,
            topConstant: 70,
            heightConstant: 100
        )
    }
    
    func setViewForTestData() {
        view.addSubview(r1)
        view.addSubview(i1)
        view.addSubview(r2)
        view.addSubview(i2)
        view.addSubview(routeToNextScreen)
        r1.anchor(
            top: navBar.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 32,
            leftConstant: 24,
            rightConstant: 24,
            heightConstant: 60
        )
        i1.anchor(
            top: r1.bottomAnchor,
            left: r1.leftAnchor,
            right: r1.rightAnchor,
            topConstant: 32,
            heightConstant: 60
        )
        r2.anchor(
            top: i1.bottomAnchor,
            left: r1.leftAnchor,
            right: r1.rightAnchor,
            topConstant: 32,
            heightConstant: 60
        )
        i2.anchor(
            top: r2.bottomAnchor,
            left: r1.leftAnchor,
            right: r1.rightAnchor,
            topConstant: 32,
            heightConstant: 60
        )
        routeToNextScreen.anchor(
            top: i2.bottomAnchor,
            left: r1.leftAnchor,
            right: r1.rightAnchor,
            topConstant: 40,
            heightConstant: 100
        )
    }
    
    func setViewForJouleLosses() {
        view.addSubview(jouleLosses)
        view.addSubview(routeToNextScreen)
        jouleLosses.anchor(
            top: navBar.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 40,
            leftConstant: 24,
            rightConstant: 24,
            heightConstant: 60
        )
        routeToNextScreen.anchor(
            top: jouleLosses.bottomAnchor,
            left: jouleLosses.leftAnchor,
            right: jouleLosses.rightAnchor,
            topConstant: 70,
            heightConstant: 100
        )
    }
    
}
