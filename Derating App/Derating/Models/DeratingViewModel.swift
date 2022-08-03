//
//  DeratingViewModel.swift
//  Derating App
//
//  Created by GIRA on 04/07/22.
//

import Foundation

class DeratingViewModel {
    
    var maxCurrent: Float = 0
    var jouleLosses: JouleLosses?
    
    func calculateCurrent(PJ1: Float, PEC1: Float, KFactor: Float) {
        self.maxCurrent = Float(sqrt((PJ1+PEC1)/(1+KFactor*PEC1)))
    }
    
    func getJouleLosses() -> JouleLosses {
        return JouleLosses(zPercent: nil, primaryResistence: nil, primaryCurrent: nil, secondaryResistence: nil, secondaryCurrent: nil, jouleLosses: 1.0)
    }
    
}
