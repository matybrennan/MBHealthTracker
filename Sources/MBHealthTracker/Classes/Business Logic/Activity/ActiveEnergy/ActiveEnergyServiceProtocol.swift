//
//  ActiveEnergyServiceProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/11/18.
//

import Foundation

public enum ActiveEnergyType {
    case today
    case thisWeek
    case betweenTimePref(start: Date, end: Date)
}

public protocol ActiveEnergyServiceProtocol: AnyObject {
    
    func activeEnergy(from type: ActiveEnergyType) async throws -> ActiveEnergy
}
