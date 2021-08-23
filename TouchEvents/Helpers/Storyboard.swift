//
//  Storyboard.swift
//  TouchEvents
//
//  Created by Golan Bar-Nov on 23/08/2021.
//

import UIKit

extension UIStoryboard {
    static let main = UIStoryboard(name: "Main", bundle: nil)

    func instantiate<T: UIViewController>() -> T {
        return instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
