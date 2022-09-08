//
//  VitalsService.swift
//  MBHealthTracker
//
//  Created by matybrennan on 9/12/19.
//

import Foundation
import HealthKit

public class VitalsService {
    
    public init() { }
}

// MARK: - FetchQuantitySample & FetchCorrelationSample
extension VitalsService: FetchQuantitySample, FetchCorrelationSample { }

// MARK: - VitalsServiceProtocol
extension VitalsService: VitalsServiceProtocol {
    
    public func bloodGlucose() async throws -> BloodGlucose {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .bloodGlucose)
        let items = samples.map { item -> BloodGlucose.Item in
            let glucoseLevel = item.quantity.doubleValue(for: HKUnit(from: "mg/dL"))
            let mealtimeInt = item.metadata?[HKMetadataKeyBloodGlucoseMealTime] as? Int ?? 0
            let mealTime = BloodGlucose.Item.MealTime(rawValue: mealtimeInt) ?? .unspecified
            return BloodGlucose.Item(date: item.startDate, bloodGlucose: glucoseLevel, mealTime: mealTime)
        }
        
        let model = BloodGlucose(items: items)
        return model
    }
    
    public func bloodPressure() async throws -> BloodPressure {
        let bloodPressureSystolicType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodPressureSystolic)
        let bloodPressureDiastolicType = try MBHealthParser.unboxAndCheckIfAvailable(quantityIdentifier: .bloodPressureDiastolic)
        let samples = try await fetchCorrelationSamples(correlationIdentifier: .bloodPressure)
        let items = samples.compactMap { item -> BloodPressure.Info? in
            guard let systolic = item.objects(for: bloodPressureSystolicType).first as? HKQuantitySample else { return nil }
            guard let diastolic = item.objects(for: bloodPressureDiastolicType).first as? HKQuantitySample else { return nil }
            
            let value1 = systolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
            let value2 = diastolic.quantity.doubleValue(for: HKUnit.millimeterOfMercury())
            
            return BloodPressure.Info(systolic: value1, diastolic: value2, startDate: item.startDate, endDate: item.endDate)
        }
        
        let model = BloodPressure(items: items)
        return model
    }
    
    public func bloodOxygen() async throws -> BloodOxygen {
        let samples = try await fetchQuantitySamples(quantityIdentifier: .oxygenSaturation)
        let items = samples.map { item -> BloodOxygen.Item in
            let percentage = item.quantity.doubleValue(for: .percent())
            return BloodOxygen.Item(date: item.startDate, oxygenSaturationPercentage: percentage)
        }
        
        let model = BloodOxygen(items: items)
        return model
    }
}

