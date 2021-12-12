//
//  GradientView.swift
//  tests
//
//  Created by Сергей Ляшенко on 08.12.2021.
//

import UIKit

@IBDesignable class GradientView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
    
    @IBInspectable var colorStart: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var colorEnd: UIColor = .white {
        didSet {
            updateColors()
        }
    }
    
    @IBInspectable var locationStart: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }
    
    @IBInspectable var locationEnd: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            updateStartPoint()
        }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            updateEndPoint()
        }
    }
    
    func updateColors() {
        gradientLayer.colors = [colorStart.cgColor, colorEnd.cgColor]
    }
    
    func updateLocations() {
        gradientLayer.locations = [locationStart as NSNumber, locationEnd as NSNumber]
    }
    
    func updateStartPoint() {
        gradientLayer.startPoint = startPoint
    }
    
    func updateEndPoint() {
        gradientLayer.endPoint = endPoint
    }
    
}
