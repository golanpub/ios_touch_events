//
//  TouchEventsViewModel.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 17/08/2021.
//

import UIKit
import os.log

protocol TouchEventsViewModeling {
    var configuration: Configuration { get set }
}

protocol TouchDetectorDelegate: AnyObject {
    func didDetectAbnormalTouch(event: TouchEvent)
}

final class TouchEventViewModel: TouchEventsViewModeling {
    private let log: OSLog
    private let tapsDetector: TapsDetector
    private let swipeDetector: SwipeDetector
    private let pressDetector: LongPressDetector
    private let persistency: TouchEventsPersistenceServicing
    private var events: [TouchEvent]
    var configuration: Configuration
    
    init(in view: UIView?,
         configuration: Configuration = .defaultConfiguration,
         persistency: TouchEventsPersistenceServicing = TouchEventsPersistenceService(),
         log: OSLog = .touchEvents) {
        self.log = log
        self.configuration = configuration
        self.persistency = persistency
        self.events = []
        
        tapsDetector = TapsDetector(configuration: configuration, in: view)
        swipeDetector = SwipeDetector(configuration: configuration, in: view)
        pressDetector = LongPressDetector(configuration: configuration, in: view)
        
        tapsDetector.delegate = self
        swipeDetector.delegate = self
        pressDetector.delegate = self
        
        // Load the saved events (not required, just showing it is possible)
        persistency.load { [weak self] events in
            self?.events = events
        }
        
        // Observe app entering background to perform saving of the cached events
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appWillEnterBackground),
                                               name: UIScene.willDeactivateNotification,
                                               object: nil)
    }
    
    @objc private func appWillEnterBackground(_ notification: Notification) {
        persistency.save(events: events)
    }
}

extension TouchEventViewModel: TouchDetectorDelegate {
    // Abnormal event handler - logs the event and displays an alert
    func didDetectAbnormalTouch(event: TouchEvent) {
        events.append(event)
        log.touchEvent(event)
        DispatchQueue.main.async { [weak self] in
            self?.showAbnormalEventAlert(event)
        }
    }
    
    private func showAbnormalEventAlert(_ event: TouchEvent) {
        let alert = UIAlertController(title: "Abnormal Touch Detected",
                                      message: "The \(event.description) exceeded the defined threshold!",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: nil))

        rootViewController?.present(alert, animated: true)
    }
}

extension TouchEventsViewModeling {
    fileprivate var rootViewController: UIViewController? {
        UIApplication.shared.windows.first?.rootViewController
    }
    
    func showConfiguration(animated: Bool) {
        let configurationViewController: ConfigurationViewController = UIStoryboard.main.instantiate()
        configurationViewController.configuration = configuration
        rootViewController?.present(configurationViewController, animated: animated, completion: nil)
    }
}

