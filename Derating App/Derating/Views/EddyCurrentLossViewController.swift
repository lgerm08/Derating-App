//
//  EddyCurrentLossViewController.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import UIKit

class EddyCurrentLossViewController: UIViewController {
    
    let viewModel = DeratingViewModel()
    var jouleLosses = JouleLosses(puJouleLosses: nil, zPercent: nil, primaryResistence: nil, primaryCurrent: nil, secondaryResistence: nil, secondaryCurrent: 1.0, siJouleLosses: nil)
    
    private lazy var navbar: NavigationBar = {
        let navBar = NavigationBar(title: "Perdas por Correntes Parasitas")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var provideEddyCurrentLosses: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Informar perdas por correntes parasitas [pu]")
        buttonView.button.addTarget(self, action: #selector(eddyCurrentLossesInformed), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var estimateAs2Percent: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Considerar 2% das perdas joulicas")
        buttonView.button.addTarget(self, action: #selector(estimateLossesAs2Percent), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var estimateAs3Percent: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Considerar 3% das perdas joulicas")
        buttonView.button.addTarget(self, action: #selector(estimateLossesAs3Percent), for: .touchUpInside)
        return buttonView
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
//        let newViewController = TestDataViewController()
//        newViewController.modalPresentationStyle = .fullScreen
//        newViewController.selectedOption = mode
//        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.backgroundColor = .white
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

