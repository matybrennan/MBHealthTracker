//
//  SleepService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 1/12/18.
//

import Foundation
import HealthKit

public class SleepService {
    
    public init() { }
}

// MARK: - FetchQuantitySample
extension SleepService: FetchCategorySample { }

// MARK: - SleepServiceProtocol
extension SleepService: SleepServiceProtocol {
    
    public func sleep() async throws -> Sleep {
        let samples = try await fetchCategorySamples(categoryIdentifier: .sleepAnalysis)
        let items = samples.map { item -> Sleep.Info in
            let style = Sleep.Info.Style(rawValue: item.value) ?? Sleep.Info.Style.awake
            return Sleep.Info(style: style, startDate: item.startDate, endDate: item.endDate)
        }
        
        let vm = Sleep(items: items)
        return vm
    }
    
    public func save(model: Sleep, extra: [String : Any]?) async throws {
        let sleepType = try MBHealthParser.unboxAndCheckIfAvailable(categoryIdentifier: .sleepAnalysis)
        try MBHealthParser.checkSharingAuthorizationStatus(for: sleepType)

        let sampleObjects = model.items.map {
            HKCategorySample(type: sleepType, value: $0.style.rawValue, start: $0.startDate, end: $0.endDate, metadata: extra)
        }

        try await healthStore.save(sampleObjects)
    }
}
