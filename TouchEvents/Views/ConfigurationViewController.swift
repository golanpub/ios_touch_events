//
//  ConfigurationViewController.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 22/08/2021.
//

import UIKit

final class ConfigurationViewController: UIViewController {
    var configuration: AbnormalConfiguration!
    
    private lazy var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    @IBOutlet private weak var tapsConfigLabel: UILabel!
    @IBOutlet private weak var tapsConfigStepper: UIStepper! {
        didSet {
            tapsConfigStepper.minimumValue = 0
            tapsConfigStepper.maximumValue = 3
            tapsConfigStepper.stepValue = 0.05
            tapsConfigStepper.wraps = true
        }
    }
    
    @IBOutlet private weak var swipeConfigLabel: UILabel!
    @IBOutlet private weak var swipeConfigStepper: UIStepper! {
        didSet {
            swipeConfigStepper.minimumValue = 0
            swipeConfigStepper.maximumValue = 500
            swipeConfigStepper.stepValue = 10
            swipeConfigStepper.wraps = true
        }
    }
    
    @IBOutlet private weak var pressConfigLabel: UILabel!
    @IBOutlet private weak var pressConfigStepper: UIStepper! {
        didSet {
            pressConfigStepper.minimumValue = 0
            pressConfigStepper.maximumValue = 10
            pressConfigStepper.stepValue = 0.5
            pressConfigStepper.wraps = true
        }
    }
    
    @IBAction private func tapsConfigValueChanged(_ sender: UIStepper) {
        configuration.minimumTimeBetweenTaps = sender.value
        tapsConfigLabel?.text = formatter.string(from: NSNumber(value: sender.value))
    }
    
    @IBAction private func swipeConfigValueChanged(_ sender: UIStepper) {
        configuration.maximumSwipeVelocity = CGFloat(sender.value)
        swipeConfigLabel?.text = formatter.string(from: NSNumber(value: sender.value))
    }
    
    @IBAction private func pressConfigValueChanged(_ sender: UIStepper) {
        configuration.minimumPressDuration = pressConfigStepper.value
        pressConfigLabel?.text = formatter.string(from: NSNumber(value: sender.value))
    }
    
    @IBAction private func dismiss(_ sender: Any?) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func configure(_ configuration: AbnormalConfiguration) {
        tapsConfigStepper.value = configuration.minimumTimeBetweenTaps
        swipeConfigStepper.value = Double(configuration.maximumSwipeVelocity)
        pressConfigStepper.value = configuration.minimumPressDuration
        
        tapsConfigValueChanged(tapsConfigStepper)
        swipeConfigValueChanged(swipeConfigStepper)
        pressConfigValueChanged(pressConfigStepper)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(configuration)
    }
}
