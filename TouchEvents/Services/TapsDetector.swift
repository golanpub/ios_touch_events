//
//  TapsDetector.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 18/08/2021.
//

import UIKit

final class TapsDetector {
    private var previousTapEventTime: CFAbsoluteTime
    private let gestureRecognizer: UITapGestureRecognizer
    
    var configuration: AbnormalTapsConfiguration
    weak var delegate: TouchDetectorDelegate?
    
    init(configuration: AbnormalTapsConfiguration, in view: UIView?) {
        self.configuration = configuration
        self.previousTapEventTime = .leastNormalMagnitude
        gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
        view?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleGesture(_ recognizer: UITapGestureRecognizer) {
        let eventTime = CFAbsoluteTimeGetCurrent()
        let elapsedTimeBetweenTaps = eventTime - previousTapEventTime
        if elapsedTimeBetweenTaps < configuration.minimumTimeBetweenTaps {
            delegate?.didDetectAbnormalTouch(event: TouchEvent(type: .tap))
        }
        previousTapEventTime = eventTime
    }
}
