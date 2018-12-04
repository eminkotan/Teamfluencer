//
//  customTextField.swift
//  TeamFluncer
//
//  Created by Emin Kotan on 26.11.2018.
//  Copyright © 2018 Team Fluncer. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        //Border
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 0.5
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        let desiredPosition = self.beginningOfDocument
        self.selectedTextRange = self.textRange(from: desiredPosition, to: desiredPosition)
        
    }

}
