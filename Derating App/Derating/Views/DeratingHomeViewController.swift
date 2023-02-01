//
//  DeratingViewController.swift
//  Derating App
//
//  Created by GIRA on 30/06/22.
//

import UIKit

class DeratingHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SwitchComponentProtocol {
    
    let viewModel = DeratingViewModel()
    
    private lazy var navbar: NavigationBar = {
       let navBar = NavigationBar(title: "Informações disponíveis")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.goBackToPreviousScreen))
        gesture.cancelsTouchesInView = false
        navBar.backSignImage.addGestureRecognizer(gesture)
        return navBar
    }()
    
    private lazy var switchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SwitchComponent.self, forCellReuseIdentifier: "switchComponent")
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

    private lazy var unselectAll: ButtonComponent = {
        let buttonView = ButtonComponent(title: "Desmarcar todos")
        buttonView.button.addTarget(self, action: #selector(unselectAllSwitchs), for: .touchUpInside)
        return buttonView
    }()

    var switches: [SwitchComponentData] = [
        SwitchComponentData(label: .twoPercentParasiteCurrentLoss, status: true),
        SwitchComponentData(label: .threePercentParasiteCurrentLoss, status: false),
        SwitchComponentData(label: .informParasiteCurrentLoss, status: false),
        SwitchComponentData(label: .ratedCondition, status: false),
        SwitchComponentData(label:.puJouleLosses, status: false),
        SwitchComponentData(label:.ratedSiLosses, status: false),
        SwitchComponentData(label:.wattsJouleLosses, status: false),
        SwitchComponentData(label:.rPercent , status: false),
        SwitchComponentData(label:.useRasOnePercent, status: false),
        SwitchComponentData(label:.puTestData, status: false),
        SwitchComponentData(label:.siTestData, status: false),
        SwitchComponentData(label:.transformerData, status: false),
        SwitchComponentData(label:.delta_deltaConnection, status: false),
        SwitchComponentData(label:.y_yConnection, status: false),
        SwitchComponentData(label:.delta_YConnection, status: false),
        SwitchComponentData(label:.y_deltaConnection, status: false),
        SwitchComponentData(label:.hasPuPrimaryRatedCurrent, status: false),
        SwitchComponentData(label:.hasAmperPrimaryRatedCurrent, status: false),
        SwitchComponentData(label:.hasPuSecondaryRatedCurrent, status: false),
        SwitchComponentData(label:.hasAmperSecondaryRatedCurrent, status: false),
        SwitchComponentData(label:.puHarmonicCurrent, status: false),
        SwitchComponentData(label:.amperHarmonicCurrent, status: false),
        SwitchComponentData(label:.amperMeasuredCurrent, status: false),
        SwitchComponentData(label:.harmonicFactor, status: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
    }
    
    @objc func unselectAllSwitchs() {
        for i in 0...switches.count - 1 {
            switches[i].status = false
        }
        switchTableView.reloadData()
    }
    
    func getValueAtKey(key: String) -> Bool {
        for switchData in switches where switchData.label == key {
            return switchData.status
        }
        return false
    }
    
    @objc func routeToNextView() {
        let availableData = AvailableData(
            isInRatedCondition: getValueAtKey(key: .ratedCondition),
            hasPuJouleLosses: getValueAtKey(key: .puJouleLosses),
            hasWattsJouleLosses: getValueAtKey(key: .wattsJouleLosses),
            hasRatedSiLosses: getValueAtKey(key: .ratedSiLosses),
            hasRPercent: getValueAtKey(key: .rPercent),
            useRasOnePercent: getValueAtKey(key: .useRasOnePercent),
            hasPuTestData: getValueAtKey(key: .puTestData),
            hasSiTestData: getValueAtKey(key: .siTestData),
            hasTransformerData: getValueAtKey(key: .transformerData),
            delta_deltaConnection: getValueAtKey(key: .delta_deltaConnection),
            y_yConnection: getValueAtKey(key: .y_yConnection),
            delta_yConnection: getValueAtKey(key: .delta_YConnection),
            y_deltaConnection: getValueAtKey(key: .y_deltaConnection),
            hasPuPrimaryRatedCurrent: getValueAtKey(key: .hasPuPrimaryRatedCurrent),
            hasAmperPrimaryRatedCurrent: getValueAtKey(key: .hasAmperPrimaryRatedCurrent),
            hasPuSecondaryRatedCurrent: getValueAtKey(key: .hasPuSecondaryRatedCurrent),
            hasAmperSecondaryRatedCurrent: getValueAtKey(key: .hasAmperSecondaryRatedCurrent),
            hasPuHarmonicCurrent: getValueAtKey(key: .puHarmonicCurrent),
            hasAmperHarmonicCurrent: getValueAtKey(key: .amperHarmonicCurrent),
            amperMeasuredCurrent: getValueAtKey(key: .amperMeasuredCurrent),
            hasHarmonicFactor: getValueAtKey(key: .harmonicFactor),
            threePercentParasiteCurrentLoss: getValueAtKey(key: .threePercentParasiteCurrentLoss),
            twoPercentParasiteCurrentLoss: getValueAtKey(key: .twoPercentParasiteCurrentLoss),
            informParasiteCurrentLoss: getValueAtKey(key: .informParasiteCurrentLoss)
        )
        let pec = availableData.threePercentParasiteCurrentLoss ? 0.03 : 0.02
        if availableData.ratedCondition && availableData.puHarmonicCurrent && !availableData.harmonicFactor && !availableData.informParasiteCurrentLoss {
            let harmonicVM = HarmonicFactorViewModel(unit: "[pu]", baseCurrent: 1.0, pj: 1.0, pec: pec)
            let newViewController = HarmonicFactorViewController(viewModel: harmonicVM)
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true, completion: nil)
        } else if availableData.hasEnoughData() {
            let newViewController = InputDataViewController(viewModel: InputDataViewModel(availableData: availableData))
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true)
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
        view.addSubview(switchTableView)
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
        switchTableView.anchor(
            top: navbar.bottomAnchor,
            left: view.leftAnchor,
            bottom: nextButton.topAnchor,
            right: view.rightAnchor,
            topConstant: 15,
            leftConstant: 10,
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
    
    func switchChangedValue(switchName: String) {
        for i in 0...switches.count - 1 where switches[i].label == switchName {
            switches[i].status = !switches[i].status
            if switchName == .threePercentParasiteCurrentLoss {
                for j in 0...switches.count - 1 where (switches[j].label == .twoPercentParasiteCurrentLoss || switches[j].label == .informParasiteCurrentLoss) {
                    switches[j].status = !switches[i].status
                }
            }
            if switchName == .twoPercentParasiteCurrentLoss {
                for j in 0...switches.count - 1 where (switches[j].label == .threePercentParasiteCurrentLoss || switches[j].label == .informParasiteCurrentLoss) {
                    switches[j].status = !switches[i].status
                }
            }
            if switchName == .informParasiteCurrentLoss {
                    for j in 0...switches.count - 1 where (switches[j].label == .twoPercentParasiteCurrentLoss || switches[j].label == .threePercentParasiteCurrentLoss) {
                    switches[j].status = !switches[i].status
                }
            }
        }
        switchTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switches.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SwitchComponent(style: .default, reuseIdentifier: "switchComponent")
        cell.selectionStyle = .none
        cell.delegate = self
        cell.isUserInteractionEnabled = true
        cell.setupCell(label: switches[indexPath.row].label, status: switches[indexPath.row].status)
        return cell
    }
    
}
