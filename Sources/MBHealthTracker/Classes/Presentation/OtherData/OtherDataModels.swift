//
//  OtherDataModels.swift
//  MBHealthTracker
//
//  Created by Maty Brennan on 9/3/2022.
//

import Foundation

public struct AlcoholConsumption {
    
    public struct Item {
        public let drinks: Double
        public let date: Date
    }
    
    public let items: [Item]
}