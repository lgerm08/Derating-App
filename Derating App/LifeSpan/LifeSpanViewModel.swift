//
//  LifeSpanViewModel.swift
//  Derating App
//
//  Created by GIRA on 06/07/22.
//
import Foundation
import Darwin

class LifeSpanViewModel {
    
    var estimatedLifeSpan: Float = 0
    let e = Darwin.M_E
    
    func estimateWithNBR5416(tempeture theta: Float) {
        self.estimatedLifeSpan = 1*pow(10, (6972.15/theta)-14.133)
    }
    
    func estimateWithANSIC5791(tempeture theta: Float) {
        self.estimatedLifeSpan = 1*pow(10, (6328.8/theta)-11.968)
    }
    
    func estimateWithPECO(tempeture theta: Float) {
        self.estimatedLifeSpan = 100*pow(Float(e), (15457.225/theta)-34.129)
    }
    
    func estimateWithMontSinger(tempeture theta: Float) {
        self.estimatedLifeSpan = 0
    }
}
