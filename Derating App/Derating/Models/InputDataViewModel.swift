//
//  InputDataViewModel.swift
//  Derating App
//
//  Created by GIRA on 08/08/22.
//

import Foundation
import UIKit

class InputDataViewModel {
    var availableData: AvailableData
    var needsTransformerData = false
    var needsTransformerPower = false
    var fields: [TextFieldObject] = []
    var jouleLossStats: JouleLossesCases = .RatedLoss
    var currentUnit: String = ""
    var fhl: Double?
    var connection = ""
    var pec: Double?
    
    init(
        availableData: AvailableData
    ) {
        self.availableData = availableData
    }
    
    func requiredInputsForPj() {
        if availableData.informParasiteCurrentLoss {
            fields.append(TextFieldObject(id: "pec", labelTitle: "Perdas por I parasitas (Base RIˆ2)", unit: "[pu]"))
        }
        if !availableData.ratedCondition {
            if availableData.puJouleLosses{
                fields.append(TextFieldObject(id: "pjPu", labelTitle: "Perdas Joule (Base RIˆ2)", unit: "[pu]"))
                jouleLossStats = .PuLoss
            } else if availableData.wattsJouleLosses {
                fields.append(TextFieldObject(id: "pjSi", labelTitle: "Perdas Joule", unit: "[W]"))
                if availableData.ratedSiLosses {
                    fields.append(TextFieldObject(id: "pjSiRated", labelTitle: "Perdas Joule nominal", unit: "[W]"))
                    jouleLossStats = .BaseInformed
                } else if availableData.puTestData {
                    fields.append(TextFieldObject(id: "r1Pu", labelTitle: "R Primário", unit: "[pu]"))
                    fields.append(TextFieldObject(id: "r2Pu", labelTitle: "R Secundário", unit: "[pu]"))
                    if availableData.hasPuPrimaryRatedCurrent && availableData.hasPuSecondaryRatedCurrent {
                        fields.append(TextFieldObject(id: "i1Pu", labelTitle: "I Primário", unit: "[pu]"))
                        fields.append(TextFieldObject(id: "i2Pu", labelTitle: "I Secundário", unit: "[pu]"))
                        fields.append(TextFieldObject(id: "sSi", labelTitle: "Potência Total", unit: "[MVA]"))
                    } else {
                        needsTransformerData = true
                    }
                    jouleLossStats = .BaseFromPuTest
                } else if availableData.siTestData {
                    fields.append(TextFieldObject(id: "r1Si", labelTitle: "R Primário", unit: "[ohms]"))
                    fields.append(TextFieldObject(id: "r2Si", labelTitle: "R Secundário", unit: "[ohms]"))
                    if availableData.hasAmperPrimaryRatedCurrent && availableData.hasAmperSecondaryRatedCurrent {
                        fields.append(TextFieldObject(id: "i1Si", labelTitle: "I Primário", unit: "[A]"))
                        fields.append(TextFieldObject(id: "i2Si", labelTitle: "I Secundário", unit: "[A]"))
                    } else {
                        needsTransformerData = true
                    }
                    jouleLossStats = .BaseFromSiTest
                } else if availableData.transformerData {
                    needsTransformerData = true
                    if availableData.hasAmperPrimaryRatedCurrent && availableData.hasAmperSecondaryRatedCurrent {
                        fields.append(TextFieldObject(id: "i1Si", labelTitle: "I Primário", unit: "[A]"))
                        fields.append(TextFieldObject(id: "i2Si", labelTitle: "I Secundário", unit: "[A]"))
                    } else {
                        connection = getConnectionType()
                    }
                    jouleLossStats = .BaseFromTrafoData
                }
            }
        }
        requiredInputForFhl()
        return
    }
    
    func getConnectionType() -> String {
        if availableData.delta_YConnection {
            return "delta-y"
        }
        if availableData.delta_deltaConnection {
            return "delta-delta"
        }
        if availableData.y_deltaConnection {
            return "y-delta"
        }
        if availableData.y_yConnection {
            return "y-y"
        }
        return ""
    }
    
    func requiredInputForFhl() {
        if !availableData.harmonicFactor {
            if availableData.puHarmonicCurrent {
                addTransformerData()
                currentUnit = "[pu]"
                if !availableData.ratedCondition {
                    fields.append(TextFieldObject(id: "ien", labelTitle: "Corrente fundamental nos enrolamentos", unit: "[pu]"))
                }
                return
            } else if availableData.amperHarmonicCurrent {
                currentUnit = "[A]"
                addTransformerData()
                fields.append(TextFieldObject(id: "ien", labelTitle: "Corrente fundamental nos enrolamentos", unit: "[A]"))
                return
            }
        } else {
            fields.append(TextFieldObject(id: "fhl", labelTitle: "Fator de Perdas Harmônicas", unit: ""))
            addTransformerData()
            return
        }
        return
    }
    
    func addTransformerData() {
        if needsTransformerData {
            fields.append(TextFieldObject(id: "u1Si", labelTitle: "Tensão Primário", unit: "[V]"))
            fields.append(TextFieldObject(id: "u2Si", labelTitle: "Tensão Secundário", unit: "[V]"))
            fields.append(TextFieldObject(id: "sSi", labelTitle: "Potência Total", unit: "[MVA]"))
            fields.append(TextFieldObject(id: "inSi", labelTitle: "Corrente Nominal", unit: "[A]"))
            fields.append(TextFieldObject(id: "zPercent", labelTitle: "Z%", unit: "[%]"))
            if availableData.rPercent {
                fields.append(TextFieldObject(id: "rPercent", labelTitle: "R%", unit: "[%]"))
            }
            if needsTransformerPower {
                fields.append(TextFieldObject(id: "sSi", labelTitle: "Potência Total", unit: "[MVA]"))
            }
        }
    }
    
    func valueAtId(id: String) -> Double? {
        for field in fields where field.id == id {
            return field.value
        }
        return nil
    }
    
    func getPowerBase() -> Double? {
        switch jouleLossStats {
        case .RatedLoss, .PuLoss:
            return nil
        case .BaseInformed:
            return valueAtId(id: "pjSiRated")
        case .BaseFromPuTest:
            let (r1, r2) = getRs()
            let (i1, i2) = getIs()
            if let s = valueAtId(id: "sSi") {
                let powerBase = (i1*r1 + i2*r2)*(s*1000000)
                return powerBase > 0 ? powerBase : nil
            }
        case .BaseFromSiTest, .BaseFromTrafoData:
            let (r1, r2) = getRs()
            let (i1, i2) = getIs()
            let powerBase = (i1*r1 + i2*r2)
            return powerBase > 0 ? powerBase : nil
        }
        return nil
    }
    
    func getRs() -> (Double, Double) {
        if let r1 = valueAtId(id: "r1Pu"), let r2 = valueAtId(id: "r2Pu") {
            return (r1, r2)
        }
        if let r1 = valueAtId(id: "r1Si"), let r2 = valueAtId(id: "r2Si") {
            return (r1, r2)
        }
        if let v1 = valueAtId(id: "u1Si"), let v2 = valueAtId(id: "u2Si"), let s = valueAtId(id: "sSi") {
            let rPercent = valueAtId(id: "rPercent") ?? 1.0
            let r1 = (pow(v1, 2)/s)*rPercent/200
            let r2 = (pow(v2, 2)/s)*rPercent/200
            return (r1, r2)
        }
        return (0.0, 0.0)
    }
    
    func getIs() -> (Double, Double) {
        if let i1 = valueAtId(id: "i1Pu"), let i2 = valueAtId(id: "i2Pu") {
            return (i1, i2)
        }
        if let i1 = valueAtId(id: "i1Si"), let i2 = valueAtId(id: "i2Si") {
            return (i1, i2)
        }
        if let s = valueAtId(id: "sSi"), let v1 = valueAtId(id: "u1Si"), let v2 = valueAtId(id: "u2Si") {
            let i1 = s*1000000/(3*v1)
            let i2 = s*1000000/(3*v2)
            return (i1, i2)
        }
        return (0.0, 0.0)
    }
}
