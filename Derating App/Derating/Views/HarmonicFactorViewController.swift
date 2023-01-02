//
//  HarmonicFactorViewController.swift
//  Derating App
//
//  Created by GIRA on 15/12/22.
//


import UIKit

class HarmonicFactorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HarmonicCurrentViewCellProtocol {
   
    var viewModel: HarmonicFactorViewModel
    
    private lazy var navbar: NavigationBar = {
       let navBar = NavigationBar(title: "Fator Harmônico")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var addLineButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Adicione corrente")
        buttonView.button.addTarget(self, action: #selector(addLine), for: .touchUpInside)
        return buttonView
    }()
    
    private lazy var harmonicFactorTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HarmonicCurrentViewCell.self, forCellReuseIdentifier: "currentInfo")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var nextButton: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Próximo")
        buttonView.button.addTarget(self, action: #selector(routeToNextView), for: .touchUpInside)
        return buttonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    init(
        viewModel: HarmonicFactorViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func routeToNextView() {
        if viewModel.hasDuplicatedOrder() {
            let action = UIAlertAction(title: "OK", style: .default)
            let alert = UIAlertController(title: "Ordem duplicada", message: "Existem dois valores de correntes inseridos para a mesma ordem harmônica", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            let fhl = viewModel.calculateFhl()
            print(fhl)
//            let deratingVM = DeratingResultViewModel()
//            let newViewController = DeratingResultViewController(viewModel: deratingVM)
//            newViewController.modalPresentationStyle = .fullScreen
//            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @objc func addLine() {
        viewModel.currents.append(nil)
        harmonicFactorTableView.reloadData()
    }
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getHarmonicFactor() -> Double {
        return 0.0
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(navbar)
        view.addSubview(addLineButton)
        view.addSubview(harmonicFactorTableView)
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
        addLineButton.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            topConstant: 20,
            leftConstant: 20,
            widthConstant: 200,
            heightConstant: 70
        )
        harmonicFactorTableView.anchor(
            top: addLineButton.bottomAnchor,
            left: view.leftAnchor,
            bottom: nextButton.topAnchor,
            right: view.rightAnchor,
            topConstant: 10,
            leftConstant: 10,
            bottomConstant: 10,
            rightConstant: 10
        )
        nextButton.anchor(
            bottom: view.bottomAnchor,
            centerX: view.centerXAnchor,
            bottomConstant: 40,
            widthConstant: 130,
            heightConstant: 80
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HarmonicCurrentViewCell(style: .default, reuseIdentifier: "currentInfo")
        cell.selectionStyle = .none
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = false
        if let current = viewModel.currents[indexPath.row] {
            cell.setTitleAndUnit(order: String(current.order), current: String(current.value), unit: viewModel.unit, index: indexPath.row, delegate: self)
        } else {
            cell.setTitleAndUnit(order: nil, current: nil, unit: viewModel.unit, index: indexPath.row, delegate: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func deleteCell(indexPath: Int) {
        viewModel.currents.remove(at: indexPath)
        harmonicFactorTableView.reloadData()
    }
    
    func currentValueDidChange(indexPath: Int, stringValue: String?) {
        if var current = viewModel.currents[indexPath] {
            current.value = stringValue?.toDouble() ?? 0.0
            viewModel.currents[indexPath] = current
        } else {
            let currentValue: Double = stringValue?.toDouble() ?? 0.0
            let harmonic = HarmonicCurrentsDataModel(order: 0, value: currentValue)
            viewModel.currents[indexPath] = harmonic
        }
    }
    
    func orderValueDidChange(indexPath: Int, stringValue: String?) {
        if var current = viewModel.currents[indexPath] {
            current.order = stringValue?.toInt() ?? 0
            viewModel.currents[indexPath] = current
        } else {
            let order: Int = stringValue?.toInt() ?? 0
            let harmonic = HarmonicCurrentsDataModel(order: order, value: 0.0)
            viewModel.currents[indexPath] = harmonic
        }
    }
    
}
