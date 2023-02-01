//
//  VariableCasesModel.swift
//  Derating App
//
//  Created by GIRA on 24/10/22.
//

import Foundation

enum JouleLossesCases {
    case RatedLoss
    case PuLoss
    case BaseInformed
    case BaseFromPuTest
    case BaseFromSiTest
    case BaseFromTrafoData
}

enum ConnectionMode {
    case YDelta
    case DeltaY
    case YY
    case DeltaDelta
}
