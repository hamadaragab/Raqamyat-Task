//
//  ExtensionView.swift
//  Task
//
//  Created by Hamada Ragab on 09/12/2022.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var viewBorderColor: UIColor {
        get {
            return UIColor.clear
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var viewborderWidth: CGFloat {
        get {
            return .zero
        }
        set {
            layer.borderWidth = newValue
        }
    }
}
