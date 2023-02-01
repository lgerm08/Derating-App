//
//  DerratingData.swift
//  Derating App
//
//  Created by GIRA on 02/08/22.
//

import Foundation

class JouleLosses {
    
    var puJouleLosses: Double?
    var siJouleLosses: Double?
    var jouleLossesBase: Double?
    var isThereEnoughData: Bool = true
    
    init(
        puJouleLosses: Double?,
        siJouleLosses: Double?,
        jouleLossesBase: Double?
    ) {
        self.puJouleLosses = puJouleLosses
        self.siJouleLosses = siJouleLosses
        self.jouleLossesBase = jouleLossesBase
        self.isThereEnoughData = (puJouleLosses != nil) || ((siJouleLosses != nil) && (jouleLossesBase != nil))
    }
    
    func getPuJouleLosses() -> Double {
        if let PjPu = puJouleLosses {
            return PjPu
        }
        if let PjW = siJouleLosses, let Pbase = jouleLossesBase {
            if Pbase > 0 {
                return PjW/Pbase
            }
        }
        return 0.0
    }
}
