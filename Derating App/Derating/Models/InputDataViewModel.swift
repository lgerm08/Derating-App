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
    var needsHarmonicFactorScreen = false
    var fields: [TextFieldObject] = []
    var jouleLossStats: JouleLossesCases = .RatedLoss
    var currentUnit: String = ""
    
    init(
        availableData: AvailableData
    ) {
        self.availableData = availableData
    }
    
    func requiredInputsForPj() {
        if !availableData.ratedCondition {
            if availableData.puJouleLosses{
                fields.append(TextFieldObject(id: "pjPu", labelTitle: "Perdas Joule Pu (Base RIˆ2)", unit: "[pu]"))
                jouleLossStats = .PuLoss
                requiredInputForFhl()
                return
            } else if availableData.wattsJouleLosses {
                fields.append(TextFieldObject(id: "pjSi", labelTitle: "Perdas Joule", unit: "[W]"))
                jouleLossStats = .SiLoss
                needsTransformerData = true
                requiredInputForFhl()
                return
            } else if availableData.puTestData {
                fields.append(TextFieldObject(id: "r1Pu", labelTitle: "R Primário", unit: "[pu]"))
                fields.append(TextFieldObject(id: "i1pu", labelTitle: "I Primário", unit: "[pu]"))
                fields.append(TextFieldObject(id: "r2Pu", labelTitle: "R Secundário", unit: "[pu]"))
                fields.append(TextFieldObject(id: "i2Pu", labelTitle: "I Secundário", unit: "[pu]"))
                jouleLossStats = .PuTestData
                requiredInputForFhl()
                return
            } else if availableData.siTestData {
                fields.append(TextFieldObject(id: "r1Si", labelTitle: "R Primário", unit: "[ohms]"))
                fields.append(TextFieldObject(id: "i1Si", labelTitle: "I Primário", unit: "[A]"))
                fields.append(TextFieldObject(id: "r2Si", labelTitle: "R Secundário", unit: "[ohms]"))
                fields.append(TextFieldObject(id: "i2Si", labelTitle: "I Secundário", unit: "[A]"))
                jouleLossStats = .SiTestData
                needsTransformerData = true
                requiredInputForFhl()
                return
            }
        }
        requiredInputForFhl()
        return
    }
    
    func requiredInputForFhl() {
        if !availableData.harmonicFactor {
            if availableData.puHarmonicCurrent {
                addTransformerData()
                currentUnit = "[pu]"
                needsHarmonicFactorScreen = true
                if !availableData.ratedCondition {
                    fields.append(TextFieldObject(id: "ien", labelTitle: "Corrente fundamental nos enrolamentos", unit: "[pu]"))
                }
                return
            } else if availableData.amperHarmonicCurrent {
                needsTransformerData = true
                needsHarmonicFactorScreen = true
                currentUnit = "[A]"
                addTransformerData()
                if !availableData.ratedCondition {
                    fields.append(TextFieldObject(id: "ien", labelTitle: "Corrente fundamental nos enrolamentos", unit: "[A]"))
                }
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
        }
    }
}
