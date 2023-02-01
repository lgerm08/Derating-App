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
    var ratedSiLosses: Bool
    var wattsJouleLosses: Bool
    var rPercent: Bool
    var useRasOnePercent: Bool
    var puTestData: Bool
    var siTestData: Bool
    var transformerData: Bool
    var delta_deltaConnection: Bool
    var y_yConnection: Bool
    var delta_YConnection: Bool
    var y_deltaConnection: Bool
    var hasPuPrimaryRatedCurrent: Bool
    var hasAmperPrimaryRatedCurrent: Bool
    var hasPuSecondaryRatedCurrent: Bool
    var hasAmperSecondaryRatedCurrent: Bool
    var puHarmonicCurrent: Bool
    var amperHarmonicCurrent: Bool
    var amperMeasuredCurrent: Bool
    var harmonicFactor: Bool
    var threePercentParasiteCurrentLoss: Bool
    var twoPercentParasiteCurrentLoss: Bool
    var informParasiteCurrentLoss: Bool
    
    init(
        isInRatedCondition: Bool,
        hasPuJouleLosses: Bool,
        hasWattsJouleLosses: Bool,
        hasRatedSiLosses: Bool,
        hasRPercent: Bool,
        useRasOnePercent: Bool,
        hasPuTestData: Bool,
        hasSiTestData: Bool,
        hasTransformerData: Bool,
        delta_deltaConnection: Bool,
        y_yConnection: Bool,
        delta_yConnection: Bool,
        y_deltaConnection: Bool,
        hasPuPrimaryRatedCurrent: Bool,
        hasAmperPrimaryRatedCurrent: Bool,
        hasPuSecondaryRatedCurrent: Bool,
        hasAmperSecondaryRatedCurrent: Bool,
        hasPuHarmonicCurrent: Bool,
        hasAmperHarmonicCurrent: Bool,
        amperMeasuredCurrent: Bool,
        hasHarmonicFactor: Bool,
        threePercentParasiteCurrentLoss: Bool,
        twoPercentParasiteCurrentLoss: Bool,
        informParasiteCurrentLoss: Bool
        
    ) {
        self.ratedCondition = isInRatedCondition
        self.puJouleLosses = hasPuJouleLosses
        self.ratedSiLosses = hasRatedSiLosses
        self.wattsJouleLosses = hasWattsJouleLosses
        self.rPercent = hasRPercent
        self.useRasOnePercent = useRasOnePercent
        self.puTestData = hasPuTestData
        self.siTestData = hasSiTestData
        self.transformerData = hasTransformerData
        self.delta_deltaConnection = delta_deltaConnection
        self.y_yConnection = y_yConnection
        self.delta_YConnection = delta_yConnection
        self.y_deltaConnection = y_deltaConnection
        self.hasPuPrimaryRatedCurrent = hasPuPrimaryRatedCurrent
        self.hasAmperPrimaryRatedCurrent = hasAmperPrimaryRatedCurrent
        self.hasPuSecondaryRatedCurrent = hasPuSecondaryRatedCurrent
        self.hasAmperSecondaryRatedCurrent = hasAmperSecondaryRatedCurrent
        self.puHarmonicCurrent = hasPuHarmonicCurrent
        self.amperHarmonicCurrent = hasAmperHarmonicCurrent
        self.amperMeasuredCurrent = amperMeasuredCurrent
        self.harmonicFactor = hasHarmonicFactor
        self.threePercentParasiteCurrentLoss = threePercentParasiteCurrentLoss
        self.twoPercentParasiteCurrentLoss = twoPercentParasiteCurrentLoss
        self.informParasiteCurrentLoss = informParasiteCurrentLoss
    }
    
    func hasEnoughData() -> Bool {
        let isEnoughForPJ: Bool = {
            var isEnough = ratedCondition || puJouleLosses || (wattsJouleLosses && puJouleLosses)
            let hasConnectionInfo = (y_yConnection || delta_deltaConnection || y_deltaConnection || delta_YConnection)
            let hasRPercent = rPercent || useRasOnePercent
            let hasRatedCurrents = (hasPuPrimaryRatedCurrent || hasAmperPrimaryRatedCurrent) && (hasPuSecondaryRatedCurrent || hasAmperSecondaryRatedCurrent)
            if !isEnough && wattsJouleLosses {
                isEnough = (puTestData && (hasPuPrimaryRatedCurrent && hasPuSecondaryRatedCurrent)) || (siTestData && transformerData) || (transformerData && hasRPercent && (hasConnectionInfo || hasRatedCurrents))
            }
            return isEnough
        }()
        let isEnoughForFHL = harmonicFactor || puHarmonicCurrent || (amperHarmonicCurrent && amperMeasuredCurrent)
        let isEnoughForPec = !(threePercentParasiteCurrentLoss && twoPercentParasiteCurrentLoss)
        
        return isEnoughForPJ && isEnoughForFHL && isEnoughForPec
    }
}
