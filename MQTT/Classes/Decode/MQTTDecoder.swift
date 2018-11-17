//
//  MQTTDecoder.swift
//  xiaodaoxueyuan
//
//  Created by ailion on 2018/11/9.
//  Copyright © 2018 ailion. All rights reserved.
//

import Foundation

class MQTTDecoder {
    
    init() {}
    
    func decodeVariableByteInteger(remainingData: Data, pointer: Int) -> (value: UInt32, newPointer: Int) {
        var newPointer = pointer
        var count = 0
        var value: UInt32 = 0
        while pointer < remainingData.count {
            let newValue = UInt32(remainingData[pointer] & 0b0111_1111) << count
            newPointer += 1
            value += newValue
            if (remainingData[pointer] & 0b1000_0000) == 0 || count >= 21 {
                /// Tail
                break
            }
            count += 7
        }
        return (value, newPointer)
    }
}
