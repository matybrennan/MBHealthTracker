//
//  HeartRateModels.swift
//  Pods-TestPod_Example
//
//  Created by Maty Brennan on 2/12/18.
//

import Foundation

public struct HeartRate {
    
    public struct Item {
        let max: Double
        let min: Double
        let average: Double

        public init(max: Double, min: Double, average: Double) {
            self.max = max
            self.min = min
            self.average = average
        }
    }
    
    // Computed from timeIntervals and if One item
    public let items: [Item]

    public init(items: [Item]) {
        self.items = items
    }
}

extension HeartRate {
    
    public var total: Double {
        return items.reduce(0.0, { (res, item) -> Double in
            return res + item.average
        })
    }
    
    public var average: Double {
        return items.isEmpty ? 0.0 : total / Double(count)
    }
    
    public var first: Item {
        return items.first!
    }
    
    public var last: Item {
        return items.last!
    }
    
    public var count: Int {
        return items.count
    }
    
}
