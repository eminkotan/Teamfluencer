//
//  XIBLoadable.swift
//  recipe
//
//  Created by Emirhan Erdogan on 11.12.2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

protocol XibLoadable {
    func loadViewFromXib()
}

extension XibLoadable where Self: UIView {
    
    func loadViewFromXib() {
        let view = viewFromNibClass()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func viewFromNibClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}
