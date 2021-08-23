//
//  OSLogger.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 17/08/2021.
//

import Foundation
import os.log

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Touch events logger
    static let touchEvents = OSLog(subsystem: subsystem, category: "touch events")
    
    func touchEvent(_ event: TouchEvent) {
        os_log("%{public}@", log: .touchEvents, type: .info, event.debugDescription)
    }
    
    func error(_ error: Error) {
        os_log("Error: %{public}@", log: .touchEvents, type: .error, error.localizedDescription)
    }
}
