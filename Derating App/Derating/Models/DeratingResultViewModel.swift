//
//  DeratingResultViewModel.swift
//  Derating App
//
//  Created by GIRA on 30/12/22.
//

import UIKit

class DeratingResultViewModel {
    
    var pj: Double
    var fhl: Double
    var pec: Double
    
    init(
        pj: Double,
        fhl: Double,
        pec: Double
    ) {
        self.pj = pj
        self.fhl = fhl
        self.pec = pec
    }
    
    func getDeratingCurrent() -> Double {
        return sqrt((pj+pec)/(1.0+fhl*pec))
    }
    
}
