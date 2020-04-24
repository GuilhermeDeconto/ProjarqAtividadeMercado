//
//  GradientView.swift
//  MarketIosApp
//
//  Created by Guilherme Deconto on 23/04/20.
//  Copyright © 2020 Guilherme Deconto. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable class GradientView: UIView {
    
    @IBInspectable var height: Double = 0.0
    @IBInspectable var width: Double = 0.0
    
    @IBInspectable var topColor: UIColor = .white {
        didSet {
            layoutSubviews()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = .white {
        didSet {
            layoutSubviews()
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
   @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    override func layoutSubviews() {
        let maskPathBottom = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft,.topRight], cornerRadii: CGSize(width: width, height: height))
        let shapeLayerBottom = CAShapeLayer()
        shapeLayerBottom.frame = self.bounds
        shapeLayerBottom.path = maskPathBottom.cgPath
        self.layer.mask = shapeLayerBottom
    }
    
}
