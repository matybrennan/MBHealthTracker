//
//  CycleTracking.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation
import HealthKit

public class CycleTracking {
    
    public init() { }
}

// MARK: - Private methods
private extension CycleTracking {
    
    func fetchGenericCycleResult(categoryIdentifier: HKCategoryTypeIdentifier, handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        
        // Confirm that the type and device works
        let type = try MBHealthParser.unbox(categoryIdentifier: categoryIdentifier)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: type, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let quantitySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("\(type.identifier) log")))
                return
            }
            
            let items = quantitySamples.map { item -> GenericCycleTrackingModel.Item in
                let style = GenericCycleTrackingModel.Item.Style(rawValue: item.value) ?? .notPresent
                return GenericCycleTrackingModel.Item(style: style, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = GenericCycleTrackingModel(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
}

// MARK: - CycleTrackingProtocol
extension CycleTracking: CycleTrackingProtocol {
    
    public func abdominalCramps(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .abdominalCramps, handler: handler)
    }
    
    public func acne(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .acne, handler: handler)
    }
    
    public func appetiteChanges(handler: @escaping (MBAsyncCallResult<AppetiteChanges>) -> Void) throws {
            
            // Confirm that the type and device works
            let appetiteChangesType = try MBHealthParser.unbox(categoryIdentifier: .appetiteChanges)
            try isDataStoreAvailable()
            
            let query = HKSampleQuery(sampleType: appetiteChangesType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
                
                guard error == nil else {
                    handler(.failed(error!))
                    return
                }
                
                guard let quantitySamples = samples as? [HKCategorySample] else {
                    handler(.failed(MBAsyncParsingError.unableToParse("appetiteChanges log")))
                    return
                }
                
                let items = quantitySamples.map { item -> AppetiteChanges.Item in
                    let type = AppetiteChanges.Item.AppetiteChangesType(rawValue: item.value) ?? .noChange
                    return AppetiteChanges.Item(type: type, startDate: item.startDate, endDate: item.endDate)
                }
                
                let model = AppetiteChanges(items: items)
                handler(.success(model))
            })
            
            healthStore.execute(query)
    }
    
    public func bladderIncontinence(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .bladderIncontinence, handler: handler)
    }
    
    public func bloating(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .bloating, handler: handler)
    }
    
    public func breastPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .breastPain, handler: handler)
    }
    
    public func cervicalMucusQuality(handler: @escaping (MBAsyncCallResult<CervicalMucusQuality>) -> Void) throws {
        
        // Confirm that the type and device works
        let cervicalMucusQualityType = try MBHealthParser.unbox(categoryIdentifier: .cervicalMucusQuality)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: cervicalMucusQualityType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("cervicalMucusQualityType log")))
                return
            }
            
            let items = categorySamples.map { item -> CervicalMucusQuality.Info in
                let type: CervicalMucusQuality.Info.MucusType = CervicalMucusQuality.Info.MucusType(rawValue: item.value) ?? .dry
                return CervicalMucusQuality.Info(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = CervicalMucusQuality(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func chills(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .chills, handler: handler)
    }
    
    public func constipation(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .constipation, handler: handler)
    }
    
    public func diarrhea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .diarrhea, handler: handler)
    }
    
    public func drySkin(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .drySkin, handler: handler)
    }
    
    public func fatigue(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .fatigue, handler: handler)
    }
    
    public func hairLoss(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .hairLoss, handler: handler)
    }
    
    public func headache(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .headache, handler: handler)
    }
    
    public func hotFlashes(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .hotFlashes, handler: handler)
    }
    
    public func lowerBackPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .lowerBackPain, handler: handler)
    }
    
    public func memoryLapse(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .memoryLapse, handler: handler)
    }
    
    public func menstrualFlow(handler: @escaping (MBAsyncCallResult<MenstrualFlow>) -> Void) throws {
        
        // Confirm that the type and device works
        let menstrualFlowType = try MBHealthParser.unbox(categoryIdentifier: .menstrualFlow)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: menstrualFlowType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("menstrualFlowType log")))
                return
            }
            
            let items = categorySamples.map { item -> MenstrualFlow.Info in
                let type: MenstrualFlow.Info.FlowType = MenstrualFlow.Info.FlowType(rawValue: item.value) ?? .unspecified
                let cycleStartInt = item.metadata?[HKMetadataKeyMenstrualCycleStart] as? Int ?? 0
                let isStartOfCylce = (cycleStartInt == 0) ? false : true
                return MenstrualFlow.Info(type: type, isStartOfCycle: isStartOfCylce, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = MenstrualFlow(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func moodChanges(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .moodChanges, handler: handler)
    }
    
    public func nausea(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .nausea, handler: handler)
    }
    
    public func nightSweats(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .nightSweats, handler: handler)
    }
    
    public func ovulation(handler: @escaping (MBAsyncCallResult<Ovulation>) -> Void) throws {
        
        // Confirm that the type and device works
        let ovulationType = try MBHealthParser.unbox(categoryIdentifier: .ovulationTestResult)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: ovulationType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("ovulationType log")))
                return
            }
            
            let items = categorySamples.map { item -> Ovulation.Info in
                let type: Ovulation.Info.ResultType = Ovulation.Info.ResultType(rawValue: item.value) ?? .indetermined
                return Ovulation.Info(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = Ovulation(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func pelvicPain(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .pelvicPain, handler: handler)
    }
    
    public func sexualActivity(handler: @escaping (MBAsyncCallResult<SexualActivity>) -> Void) throws {
        
        // Confirm that the type and device works
        let sexualActivityType = try MBHealthParser.unbox(categoryIdentifier: .sexualActivity)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: sexualActivityType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("sexualActivityType log")))
                return
            }
            
            let items = categorySamples.map { item -> SexualActivity.Info in
                
                let styleInt = item.metadata?[HKMetadataKeySexualActivityProtectionUsed] as? Int ?? -1
                let type: SexualActivity.Info.StyleType = SexualActivity.Info.StyleType(rawValue: styleInt) ?? .unspecified
                return SexualActivity.Info(type: type, startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = SexualActivity(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func sleepChanges(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .sleepChanges, handler: handler)
    }
    
    public func spotting(handler: @escaping (MBAsyncCallResult<Spotting>) -> Void) throws {
        
        // Confirm that the type and device works
        let spottingType = try MBHealthParser.unbox(categoryIdentifier: .intermenstrualBleeding)
        try isDataStoreAvailable()
        
        let query = HKSampleQuery(sampleType: spottingType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: { (sampleQuery, samples, error) in
            
            guard error == nil else {
                handler(.failed(error!))
                return
            }
            
            guard let categorySamples = samples as? [HKCategorySample] else {
                handler(.failed(MBAsyncParsingError.unableToParse("spottingType log")))
                return
            }
            
            let items = categorySamples.map { item -> Spotting.Info in
                return Spotting.Info(startDate: item.startDate, endDate: item.endDate)
            }
            
            let model = Spotting(items: items)
            handler(.success(model))
        })
        
        healthStore.execute(query)
    }
    
    public func vaginalDryness(handler: @escaping (MBAsyncCallResult<GenericCycleTrackingModel>) -> Void) throws {
        try fetchGenericCycleResult(categoryIdentifier: .vaginalDryness, handler: handler)
    }
}
