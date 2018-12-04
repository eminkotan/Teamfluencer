//
//  File.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 25.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomButton: UIButton {
    var shadowAdded: Bool = false
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if shadowAdded { return }
        shadowAdded = true
        
        let shadowLayer = UIView(frame: self.frame)
        shadowLayer.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        shadowLayer.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowLayer.layer.shadowOpacity = 0.9
        shadowLayer.layer.shadowRadius = 11
        shadowLayer.layer.masksToBounds = true
        shadowLayer.clipsToBounds = false
        
        self.superview?.addSubview(shadowLayer)
        self.superview?.bringSubviewToFront(self)
    }
}
