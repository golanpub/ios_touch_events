//
//  ViewController.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 16/08/2021.
//

import UIKit

class TouchEventsViewController: UIViewController {
    @IBOutlet private weak var touchEventsView: TouchEventsView!
    
    @IBAction func showConfiguration(_ sender: Any?) {
        touchEventsView.showConfiguration(animated: true)
    }
}
