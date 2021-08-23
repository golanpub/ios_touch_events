//
//  SwipeDetector.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 19/08/2021.
//

import UIKit

final class SwipeDetector {
    var configuration: AbnormalSwipeConfiguration
    weak var delegate: TouchDetectorDelegate?
    private let gestureRecognizer: UIPanGestureRecognizer
    
    init(configuration: AbnormalSwipeConfiguration, in view: UIView?) {
        self.configuration = configuration
        gestureRecognizer = UIPanGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
        view?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleGesture(_ recognizer: UIPanGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        let velocity = recognizer.velocity(in: recognizer.view).normalized
        if velocity > configuration.maximumSwipeVelocity {
            recognizer.reset()
            let event = TouchEvent(type: .swipe)
            delegate?.didDetectAbnormalTouch(event: event)
        }
    }
}
