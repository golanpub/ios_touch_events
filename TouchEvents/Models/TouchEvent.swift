//
//  TouchEvent.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 17/08/2021.
//

import Foundation

struct TouchEvent: Codable {
    enum EventType: String, Codable {
        case tap, swipe, press
    }
    
    let type: EventType
    let time: Date
    
    init(type: EventType, time: Date = Date()) {
        self.type = type
        self.time = time
    }
}

extension TouchEvent: CustomStringConvertible {
    var description: String {
        type.rawValue.capitalized
    }
}

extension TouchEvent: CustomDebugStringConvertible {
    var debugDescription: String {
        let time = DateFormatter.localizedString(from: time, dateStyle: .none, timeStyle: .medium)
        return "\(description) (\(time))"
    }
}
