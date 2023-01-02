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
