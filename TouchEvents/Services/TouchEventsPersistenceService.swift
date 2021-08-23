//
//  TouchEventsPersistenceService.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 22/08/2021.
//

import UIKit
import os.log

protocol TouchEventsPersistenceServicing {
    func save(events: [TouchEvent])
    func load(completion: @escaping ([TouchEvent]) -> Void)
}

final class TouchEventsPersistenceService: TouchEventsPersistenceServicing {
    private lazy var fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("events.data")
    private lazy var queue = DispatchQueue(label: "com.biocatch.events.store", qos: .userInitiated)
    private var backgroundTaskID: UIBackgroundTaskIdentifier?
    
    func save(events: [TouchEvent]) {
        let file = fileURL
        queue.async { [weak self] in
            let application = UIApplication.shared
            self?.backgroundTaskID = application.beginBackgroundTask (withName: "Finish Saving tasks") {
                self?.endBackgroundTask() // End the task if time expires
            }
            
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(events)
                try data.write(to: file)
            } catch {
                OSLog.touchEvents.error(error)
            }
            
            self?.endBackgroundTask()
        }
    }
    
    private func endBackgroundTask() {
        if let backgroundTaskID = self.backgroundTaskID {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
        }
        backgroundTaskID = .invalid
    }
    
    func load(completion: @escaping ([TouchEvent]) -> Void) {
        let file = fileURL
        var events = [TouchEvent]()
        queue.async {
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: file)
                events = try decoder.decode([TouchEvent].self, from: data)
            } catch {
                OSLog.touchEvents.error(error)
            }
            DispatchQueue.main.async {
                completion(events)
            }
        }
    }
}
