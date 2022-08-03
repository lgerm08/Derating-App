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
       let navBar = NavigationBar(title: "Selecione os dados disponíveis")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var provideZPercent: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Tenho Z percentual [pu]", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(proceedWithZPercent), for: .touchUpInside)
        return button
    }()
    
    private lazy var provideTestInfo: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Tenho Dados de Ensaio [pu]", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(proceedWithTestData), for: .touchUpInside)
        return button
    }()
    
    private lazy var provideJouleLosses: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.backgroundColor = UIColor().RGBColor(r: 214, g: 164, b: 64)
        button.tintColor = UIColor().RGBColor(r: 245, g: 238, b: 184)
        button.setTitle("Tenho as Perdas Joulicas [pu]", for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 2.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(proceedWithJouleLosses), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    @objc func proceedWithZPercent() {
        goToInputJouleLosses(mode: .zPercent)
    }
    
    @objc func proceedWithTestData() {
        goToInputJouleLosses(mode: .transformerTests)
    }
    
    @objc func proceedWithJouleLosses() {
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
        view.addSubview(provideZPercent)
        view.addSubview(provideTestInfo)
        view.addSubview(provideJouleLosses)
        addConstraints()
    }
    
    func addConstraints() {
        navbar.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 120
        )
        provideZPercent.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            topConstant: 50,
            leftConstant: 45,
            rightConstant: 45,
            heightConstant: 100
        )
        provideTestInfo.anchor(
            top: provideZPercent.bottomAnchor,
            left: provideZPercent.leftAnchor,
            right: provideZPercent.rightAnchor,
            topConstant: 40,
            heightConstant: 100
        )
        provideJouleLosses.anchor(
            top: provideTestInfo.bottomAnchor,
            left: provideZPercent.leftAnchor,
            right: provideZPercent.rightAnchor,
            topConstant: 40,
            heightConstant: 100
        )
    }
}
