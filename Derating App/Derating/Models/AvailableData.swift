//
//  AvailableData.swift
//  Derating App
//
//  Created by GIRA on 08/08/22.
//

import Foundation

class AvailableData {
    var ratedCondition: Bool
    var puJouleLosses: Bool
    var wattsJouleLosses: Bool
    var rPercent: Bool
    var puTestData: Bool
    var siTestData: Bool
    var transformerData: Bool
    var puHarmonicCurrent: Bool
    var amperHarmonicCurrent: Bool
    var amperMeasuredCurrent: Bool
    var harmonicFactor: Bool
    
    init(
        isInRatedCondition: Bool,
        hasPuJouleLosses: Bool,
        hasWattsJouleLosses: Bool,
        hasRPercent: Bool,
        hasPuTestData: Bool,
        hasSiTestData: Bool,
        hasTransformerData: Bool,
        hasPuHarmonicCurrent: Bool,
        hasAmperHarmonicCurrent: Bool,
        amperMeasuredCurrent: Bool,
        hasHarmonicFactor: Bool
    ) {
        self.ratedCondition = isInRatedCondition
        self.puJouleLosses = hasPuJouleLosses
        self.wattsJouleLosses = hasWattsJouleLosses
        self.rPercent = hasRPercent
        self.puTestData = hasPuTestData
        self.siTestData = hasSiTestData
        self.transformerData = hasTransformerData
        self.puHarmonicCurrent = hasPuHarmonicCurrent
        self.amperHarmonicCurrent = hasAmperHarmonicCurrent
        self.amperMeasuredCurrent = amperMeasuredCurrent
        self.harmonicFactor = hasHarmonicFactor
    }
    
    func hasEnoughData() -> Bool {
        let isEnoughForPJ: Bool = {
            var isEnough = ratedCondition || puJouleLosses || (wattsJouleLosses && transformerData)
            if !isEnough {
                isEnough = puTestData || (siTestData && transformerData)
            }
            return isEnough
        }()
        let isEnoughForFHL = harmonicFactor || puHarmonicCurrent || (amperHarmonicCurrent && transformerData && (ratedCondition || amperMeasuredCurrent))
        
        return isEnoughForPJ && isEnoughForFHL
    }
}
