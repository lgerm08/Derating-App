//
//  HarmonicFactorViewModel.swift
//  Derating App
//
//  Created by GIRA on 15/12/22.
//

import Foundation

class HarmonicFactorViewModel {
    
    var baseCurrent: Double
    var unit: String
    var currents: [HarmonicCurrentsDataModel?] = []
    var pj: JouleLosses
    
    init(
        unit: String,
        baseCurrent: Double,
        pj: JouleLosses
    ) {
        self.unit = unit
        self.baseCurrent = baseCurrent
        self.pj = pj
    }
    
    func hasDuplicatedOrder() -> Bool {
        var nilCounter = 0
        for current in currents {
            let aux = currents.filter({
                ($0?.order == current?.order) && $0 != nil
            })
            if aux.count > 1 {
                return true
            }
            if current == nil {
                nilCounter += 1
            }
        }
        return currents.isEmpty || nilCounter == currents.count
    }
    
    func calculateFhl() -> Double {
        var numerator: Double = 1
        var denominator: Double = 1
        for current in currents {
            if let i = current {
                if i.order != 1 {
                    numerator += pow(Double(i.order), 2)*pow((i.value/baseCurrent), 2)
                    denominator += pow((i.value/baseCurrent), 2)
                }
            }
        }
        return numerator/denominator
    }
    
}
