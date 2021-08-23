//
//  CGMathExtensions.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 19/08/2021.
//

import Foundation
import CoreGraphics

extension CGPoint {
    var quadrance: CGFloat {
        x * x + y * y
    }
    
    var normalized: CGFloat {
        guard self != .zero else { return 0 }
        return sqrt(quadrance)
    }
}


