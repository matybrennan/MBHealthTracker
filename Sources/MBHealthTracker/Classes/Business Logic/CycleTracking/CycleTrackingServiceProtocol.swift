//
//  CycleTrackingProtocol.swift
//  MBHealthTracker
//
//  Created by matybrennan on 27/9/19.
//

import Foundation

public protocol CycleTrackingProtocol: AnyObject {
    
    // Fetch
    func abdominalCramps() async throws -> GenericSymptomModel
    func bloating() async throws -> GenericSymptomModel
    func breastPain() async throws -> GenericSymptomModel
    func cervicalMucusQuality() async throws -> CervicalMucusQuality
    func menstruation() async throws -> Menstruation
    func moodChanges() async throws -> GenericSymptomModel
    func ovulation() async throws -> Ovulation
    func pregnancyTestResult() async throws -> PregnancyTestResult
    func progesteroneTestResult() async throws -> ProgesteroneTestResult
    func sexualActivity() async throws -> SexualActivity
    func spotting() async throws -> Spotting
    func vaginalDryness() async throws -> GenericSymptomModel

    // Save
    func saveAbdominalCramps(model: GenericSymptomModel, extra: [String : Any]?) async throws
    func saveBloating(model: GenericSymptomModel, extra: [String : Any]?) async throws
    func saveBreastPain(model: GenericSymptomModel, extra: [String : Any]?) async throws
    func saveCervicalMucusQuality(model: CervicalMucusQuality, extra: [String : Any]?) async throws
    func saveMenstruation(model: Menstruation, extra: [String : Any]?) async throws
    func saveMoodChanges(model: GenericSymptomModel, extra: [String : Any]?) async throws
    func saveOvulation(model: Ovulation, extra: [String : Any]?) async throws
    func savePregnancyTestResult(model: PregnancyTestResult, extra: [String : Any]?) async throws
    func saveProgesteroneTestResult(model: ProgesteroneTestResult, extra: [String : Any]?) async throws
    func saveSexualActivity(model: SexualActivity, extra: [String : Any]?) async throws
    func saveSpotting(model: Spotting, extra: [String : Any]?) async throws
    func saveVaginalDryness(model: GenericSymptomModel, extra: [String : Any]?) async throws
}
