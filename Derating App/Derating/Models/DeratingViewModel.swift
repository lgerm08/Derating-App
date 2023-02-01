//
//  DeratingViewModel.swift
//  Derating App
//
//  Created by GIRA on 04/07/22.
//

import Foundation

class DeratingViewModel {
    
    var maxCurrent: Double = 0
    var jouleLosses: JouleLosses?
    
    func calculateCurrent(PJ1: Double, PEC1: Double, KFactor: Double) {
        self.maxCurrent = Double(sqrt((PJ1+PEC1)/(1+KFactor*PEC1)))
    }
    
}
