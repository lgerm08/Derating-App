//
//  String_Extension.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import Foundation

extension String{
    
    static let zPercent = "Informe o Z%"
    static let transformerTests = "Informe os dados do ensaio"
    static let jouleLosses = "Informe as Perdas Joulicas"
    
    static let provideEddyCurrent = "Informe as perdas nos enrolamentos por correntes parasitas"
    static let estimateAsTwoPercent = "Estimar como 2 por cento"
    static let estimateAsThreePercente = "Estimar como 3 por cento"
    
    static let factorK = "Informe o Fator K"
    static let harmonicCurrentes = "Informe as Correntes Harmônicas"
    
    static let ratedCondition = "Opera em condições nominais"
    static let puJouleLosses = "Perdas Joules pu na base RIˆ2"
    static let ratedSiLosses = "Perdas Joules nominal [W]" 
    static let wattsJouleLosses =  "Perda Joules Medida [W]" 
    static let rPercent = "Resistência percentual (R%)" 
    static let useRasOnePercent = "Considerar R = 1% de Zbase"
    static let puTestData = "Dados de Ensaio de Curto-Circuito [pu]"
    static let siTestData = "Dados de Ensaio de Curto-Circuito [SI]"
    static let transformerData = "Dados de Placa"
    static let delta_deltaConnection = "Conexão Delta-Delta"
    static let y_yConnection = "Conexão Y-Y"
    static let delta_YConnection = "Conexão Delta-Y" 
    static let y_deltaConnection = "Conexão Y-Delta" 
    static let hasPuPrimaryRatedCurrent = "Corrente nominal no primário [pu]"
    static let hasAmperPrimaryRatedCurrent = "Corrente nominal no primário [A]" 
    static let hasPuSecondaryRatedCurrent = "Corrente nominal no secundário [pu]"
    static let hasAmperSecondaryRatedCurrent = "Corrente nominal no secundário [A]"
    static let puHarmonicCurrent = "Correntes harmônicas [pu]" 
    static let amperHarmonicCurrent = "Correntes harmônicas [A]" 
    static let amperMeasuredCurrent = "Corrente medida nos enrolamentos [A]" 
    static let harmonicFactor = "Fator harmônico (Fhl)"
    static let threePercentParasiteCurrentLoss = "Estimar Perdas por I parasitas como 3% da perda joule"
    static let twoPercentParasiteCurrentLoss = "Estimar Perdas por I parasitas como 2% da perda joule"
    static let informParasiteCurrentLoss = "Perdas por I parasitas em F fundamental [pu]"
    
    func toDouble() -> Double? {
        if let doubleAnswer = Double(self) {
            return doubleAnswer
        }
        var doubleString = self.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        doubleString = doubleString.replacingOccurrences(of: ",", with: ".", options: NSString.CompareOptions.literal, range: nil)
        doubleString = doubleString.trimmingCharacters(in: .whitespaces)
        if let doubleAnswer = Double(doubleString) {
            return doubleAnswer
        }
        return nil
    }
    
    func toInt() -> Int? {
        var intString = self.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil)
        intString = intString.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
        intString = intString.trimmingCharacters(in: .whitespaces)
        if let intAnswer = Int(intString) {
            return intAnswer
        }
        return nil
    }

}
