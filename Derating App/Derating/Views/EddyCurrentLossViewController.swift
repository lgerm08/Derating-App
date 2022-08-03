//
//  EddyCurrentLossViewController.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import UIKit

class EddyCurrentLossViewController: UIViewController {
    
    let viewModel = DeratingViewModel()
    var jouleLosses = JouleLosses(zPercent: nil, primaryResistence: nil, primaryCurrent: nil, secondaryResistence: nil, secondaryCurrent: nil, jouleLosses: 1.0)
    
    private lazy var navbar: NavigationBar = {
        let navBar = NavigationBar(title: "Perdas por Correntes Parasitas")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var provideEddyCurrentLosses: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Informar perdas por correntes parasitas [pu]", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(eddyCurrentLossesInformed), for: .touchUpInside)
        return button
    }()
    
    private lazy var estimateAs2Percent: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Considerar 2% das perdas joulicas", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(estimateLossesAs2Percent), for: .touchUpInside)
        return button
    }()
    
    private lazy var estimateAs3Percent: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Considerar 3% das perdas joulicas", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(estimateLossesAs3Percent), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    @objc func eddyCurrentLossesInformed() {
        goToInputJouleLosses(mode: .zPercent)
    }
    
    @objc func estimateLossesAs2Percent() {
        goToInputJouleLosses(mode: .transformerTests)
    }
    
    @objc func estimateLossesAs3Percent() {
        goToInputJouleLosses(mode: .jouleLosses)
    }
    
    func goToInputJouleLosses(mode: String) {
        let newViewController = InputJouleLossesViewController()
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.selectedOption = mode
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.backgroundColor = UIColor().RGBColor(r: 45, g: 111, b: 158)
        view.addSubview(navbar)
        view.addSubview(provideEddyCurrentLosses)
        view.addSubview(estimateAs2Percent)
        view.addSubview(estimateAs3Percent)
        addConstraints()
    }
    
    func addConstraints() {
        navbar.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 120
        )
        provideEddyCurrentLosses.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 50,
            leftConstant: 45,
            rightConstant: 45,
            heightConstant: 100
        )
        estimateAs2Percent.anchor(
            top: provideEddyCurrentLosses.bottomAnchor,
            left: provideEddyCurrentLosses.leftAnchor,
            right: provideEddyCurrentLosses.rightAnchor,
            topConstant: 40,
            heightConstant: 100
        )
        estimateAs3Percent.anchor(
            top: estimateAs2Percent.bottomAnchor,
            left: provideEddyCurrentLosses.leftAnchor,
            right: provideEddyCurrentLosses.rightAnchor,
            topConstant: 40,
            heightConstant: 100
        )
    }
}

