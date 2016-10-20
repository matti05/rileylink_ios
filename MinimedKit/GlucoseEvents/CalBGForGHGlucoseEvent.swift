//
//  CalBGForGHGlucoseEvent.swift
//  RileyLink
//
//  Created by Timothy Mecklem on 10/16/16.
//  Copyright © 2016 Pete Schwamb. All rights reserved.
//

import Foundation

public struct CalBGForGHGlucoseEvent : GlucoseEvent {
    public let length: Int
    public let rawData: Data
    public let timestamp: DateComponents
    public let amount: Int
    
    public init?(availableData: Data, pumpModel: PumpModel) {
        length = 6
        
        guard length <= availableData.count else {
            return nil
        }
        
        func d(_ idx:Int) -> Int {
            return Int(availableData[idx] as UInt8)
        }
        
        rawData = availableData.subdata(in: 0..<length)
        timestamp = DateComponents(glucoseEventBytes: availableData.subdata(in: 1..<5))
        amount = Int( (UInt16(d(3) & 0b00100000) << 3) | UInt16(d(5)) )
    }
    
    public var dictionaryRepresentation: [String: Any] {
        return [
            "name": "CalBGForGH",
            "amount": amount
        ]
    }
}
