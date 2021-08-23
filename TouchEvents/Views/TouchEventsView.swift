//
//  TouchView.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 17/08/2021.
//

import UIKit

final class TouchEventsView: UIView {
    private var viewModel: TouchEventsViewModeling!
    
    init(viewModel: TouchEventsViewModeling) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        viewModel = TouchEventViewModel(in: self)
    }
    
    func showConfiguration(animated: Bool) {
        viewModel.showConfiguration(animated: animated)
    }
}

