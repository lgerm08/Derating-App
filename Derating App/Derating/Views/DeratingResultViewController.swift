//
//  DeratingResultViewModel.swift
//  Derating App
//
//  Created by GIRA on 30/12/22.
//

import UIKit

class DeratingResultViewController: UIViewController {
    
    var viewModel: DeratingResultViewModel
    
    private lazy var navbar: NavigationBar = {
       let navBar = NavigationBar(title: "Resultado")
        navBar.backSignImage.isHidden = true
        return navBar
    }()
    
    private lazy var returnButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Voltar para tela inicial")
        buttonView.button.addTarget(self, action: #selector(routeToHomeScreen), for: .touchUpInside)
        return buttonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    init(
        viewModel: DeratingResultViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func routeToHomeScreen() {
       
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(navbar)
        view.addSubview(returnButton)
        addConstraints()
    }
    
    func addConstraints() {
        navbar.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            heightConstant: 120
        )
        returnButton.anchor(
            bottom: view.bottomAnchor,
            centerX: view.centerXAnchor,
            bottomConstant: 40,
            widthConstant: 130,
            heightConstant: 80
        )
    }
}
