//
//  File.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import Foundation
 
class EddyCurrentLosses {
    
    var eddyCurrentLoss: Double
    var isThereEnoughData = true
    
    init(
        eddyCurrentLoss: Double?,
        jouleLosses: Double?,
        estimatedPercentage: Double?
    ){
        if let pec = eddyCurrentLoss {
            self.eddyCurrentLoss = pec
        } else if let pj = jouleLosses, let percent = estimatedPercentage {
            self.eddyCurrentLoss = pj*percent
        } else {
            self.eddyCurrentLoss = 0.0
            isThereEnoughData = false
        }
    }
}
