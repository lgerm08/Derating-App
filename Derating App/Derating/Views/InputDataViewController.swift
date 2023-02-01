//
//  InputDataViewController.swift
//  Derating App
//
//  Created by GIRA on 08/08/22.
//

import UIKit

class InputDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, InputViewCellProtocol {
    
    var viewModel: InputDataViewModel
    
    private lazy var navbar: NavigationBar = {
       let navBar = NavigationBar(title: "Preencha as seguintes informações")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var inputTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(InputViewCell.self, forCellReuseIdentifier: "textInput")
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
    
    private var cellBeingEdited: Int = 0
    private var powerBase: Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.requiredInputsForPj()
        addSubviews()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    init(
        viewModel: InputDataViewModel
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
        let pj = generatePjVarialbe()
        viewModel.fhl = viewModel.valueAtId(id: "fhl")
        if viewModel.availableData.informParasiteCurrentLoss {
            viewModel.pec = viewModel.valueAtId(id: "pec")
        } else {
            viewModel.pec = viewModel.availableData.twoPercentParasiteCurrentLoss ? 0.02 : 0.03
        }
        if pj.isThereEnoughData && viewModel.pec != nil{
            if let fhl = viewModel.fhl {
                let deratingVM = DeratingResultViewModel(pj: pj.getPuJouleLosses(), fhl: fhl, pec: viewModel.pec!)
                let newViewController = DeratingResultViewController(viewModel: deratingVM)
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)

            } else {
                let harmonicVM = HarmonicFactorViewModel(unit: viewModel.currentUnit, baseCurrent: viewModel.valueAtId(id: "ien") ?? 1.0, pj: pj.getPuJouleLosses(), pec: viewModel.pec!)
                let newViewController = HarmonicFactorViewController(viewModel: harmonicVM)
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            }
        } else {
            let action = UIAlertAction(title: "OK", style: .default)
            let alert = UIAlertController(title: "Dados Insuficientes", message: "Não é possível calcular a perda joule [pu] sem preencher todos os campos", preferredStyle: .alert)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
 
    func generatePjVarialbe() -> JouleLosses {
        switch viewModel.jouleLossStats {
        case .RatedLoss:
            return JouleLosses(puJouleLosses: 1.0, siJouleLosses: nil, jouleLossesBase: nil)
        case .PuLoss:
            return JouleLosses(puJouleLosses: viewModel.valueAtId(id: "pjPu"), siJouleLosses: nil, jouleLossesBase: nil)
        case .BaseInformed, .BaseFromPuTest, .BaseFromSiTest, .BaseFromTrafoData:
            return JouleLosses(puJouleLosses: nil, siJouleLosses: viewModel.valueAtId(id: "pjSi"), jouleLossesBase: viewModel.getPowerBase())
        }
    }
   
    
    @objc func goBackToPreviousScreen(sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addSubviews() {
        view.backgroundColor = .white
        view.addSubview(navbar)
        view.addSubview(inputTableView)
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
        inputTableView.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            bottom: nextButton.topAnchor,
            right: view.rightAnchor,
            topConstant: 15,
            leftConstant: 15,
            rightConstant: 15
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
        return viewModel.fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = InputViewCell(style: .default, reuseIdentifier: "textInput")
        cell.selectionStyle = .none
        cell.delegate = self
        cell.contentView.isUserInteractionEnabled = false
        cell.setTitleAndUnit(title: viewModel.fields[indexPath.row].labelTitle, unit: viewModel.fields[indexPath.row].unit, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func areaTextFieldDidChange(indexPath: Int, stringValue: String?) {
        if let text = stringValue {
            viewModel.fields[indexPath].value = text.toDouble()
        }
    }
}
