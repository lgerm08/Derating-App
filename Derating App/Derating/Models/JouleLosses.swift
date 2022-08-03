//
//  DerratingData.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import Foundation

class JouleLosses {
    
    var zPercent: Double?
    var primaryResistence: Double?
    var primaryCurrent: Double?
    var secondaryResistence: Double?
    var secondaryCurrent: Double?
    var jouleLosses: Double?
    
    var isThereEnoughData: Bool = true
    
    init(
        zPercent: Double?,
        primaryResistence: Double?,
        primaryCurrent: Double?,
        secondaryResistence: Double?,
        secondaryCurrent: Double?,
        jouleLosses: Double?
    ) {
        if let zPercent = zPercent {
            self.zPercent = zPercent
        } else if let r1 = primaryResistence, let i1 = primaryCurrent, let r2 = secondaryResistence, let i2 = secondaryCurrent {
            self.primaryResistence = r1
            self.primaryCurrent = i1
            self.secondaryResistence = r2
            self.secondaryCurrent = i2
        } else if let pj = jouleLosses {
            self.jouleLosses = pj
        } else {
            isThereEnoughData = false
        }
    }
    
    
}
