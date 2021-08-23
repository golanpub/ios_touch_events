//
//  LongPressDetector.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 19/08/2021.
//

import UIKit

final class LongPressDetector {
    var configuration: AbnormalPressConfiguration
    weak var delegate: TouchDetectorDelegate?
    private let gestureRecognizer: UILongPressGestureRecognizer
    
    init(configuration: AbnormalPressConfiguration, in view: UIView?) {
        self.configuration = configuration
        gestureRecognizer = UILongPressGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
        gestureRecognizer.minimumPressDuration = configuration.minimumPressDuration
        view?.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleGesture(_ recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .ended else { return }
        delegate?.didDetectAbnormalTouch(event: TouchEvent(type: .press))
    }
}
