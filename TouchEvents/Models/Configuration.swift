//
//  AbnormalTouchConfiguration.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 17/08/2021.
//

import UIKit

protocol AbnormalTapsConfiguration {
    /// The number seconds between taps that should pass for a normal speed.
    //  If the time between taps exceeds this limit the speed is considered normal.
    var minimumTimeBetweenTaps: TimeInterval { get set }
}

protocol AbnormalSwipeConfiguration {
    var maximumSwipeVelocity: CGFloat { get set }
}

protocol AbnormalPressConfiguration {
    var minimumPressDuration: TimeInterval { get set }
}

typealias AbnormalConfiguration = AbnormalTapsConfiguration & AbnormalSwipeConfiguration & AbnormalPressConfiguration

final class Configuration: AbnormalConfiguration {
    var minimumTimeBetweenTaps: TimeInterval
    var maximumSwipeVelocity: CGFloat
    var minimumPressDuration: TimeInterval
    
    init(minimumTimeBetweenTaps: TimeInterval, maximumSwipeVelocity: CGFloat, minimumPressDuration: TimeInterval) {
        self.minimumTimeBetweenTaps = minimumTimeBetweenTaps
        self.maximumSwipeVelocity = maximumSwipeVelocity
        self.minimumPressDuration = minimumPressDuration
    }
    
    private convenience init() {
        self.init(minimumTimeBetweenTaps: 0.25,
                  maximumSwipeVelocity: 1000,
                  minimumPressDuration: 1)
    }
    
    static let defaultConfiguration = Configuration()
}
