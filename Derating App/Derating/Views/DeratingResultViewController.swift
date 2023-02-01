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
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()
    
    private lazy var deratingCurrent = AnswerComponent()
    
    private lazy var returnButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Páginal Inicial")
        buttonView.button.addTarget(self, action: #selector(routeToHomeScreen), for: .touchUpInside)
        return buttonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deratingCurrent.setLabels(label: "Corrente de Derating", value: viewModel.getDeratingCurrent(), unit: "[pu]")
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
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1200)
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(navbar)
        view.addSubview(scrollView)
        view.addSubview(returnButton)
        setScrollView()
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
            bottom: returnButton.topAnchor,
            right: view.rightAnchor,
            topConstant: 10,
            bottomConstant: 10
        )
        returnButton.anchor(
            bottom: view.bottomAnchor,
            centerX: view.centerXAnchor,
            bottomConstant: 40,
            widthConstant: 130,
            heightConstant: 80
        )
    }
    
    func setScrollView() {
        scrollView.addSubview(deratingCurrent)
        deratingCurrent.anchor(
            top: scrollView.topAnchor,
            centerX: scrollView.centerXAnchor,
            topConstant: 10,
            leftConstant: 15,
            rightConstant: 15,
            widthConstant: 300,
            heightConstant: 230
        )
    }
}
