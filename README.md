# Abnormal Touch Events Detection

## Usage
- Just add `TouchEventsView` to your view controller

- For displaying the configuration screen call the `touchEventsView.showConfiguration(animated: true)`

Please see `TouchEventsViewController` for sample implementation.


## How does it work?

The `TouchEventViewModel` uses three detectors (gesture recognizers) to detect abnormal swipes, taps and long presses.

The long press detector is simply configured to report events exceeding preconfigured values set by a global configuration object.
```swift
longPressGestureRecognizer.minimumPressDuration = configuration.minimumPressDuration
```

The fast taps detector is testing for too short time difference from the revious tap
```swift
let eventTime = CFAbsoluteTimeGetCurrent()
let elapsedTimeBetweenTaps = eventTime - previousTapEventTime
if elapsedTimeBetweenTaps < configuration.minimumTimeBetweenTaps {
    delegate?.didDetectAbnormalTouch(event: TouchEvent(type: .tap))
}
previousTapEventTime = eventTime
```

The fast swipe detector calculates the velocity of the swipe and compares it to the configured threshold
```swift
let velocity = recognizer.velocity(in: recognizer.view).normalized
if velocity > configuration.maximumSwipeVelocity {
    delegate?.didDetectAbnormalTouch(event: TouchEvent(type: .swipe))
}
```

