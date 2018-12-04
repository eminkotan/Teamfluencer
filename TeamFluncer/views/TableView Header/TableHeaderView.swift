//
//  TableHeaderView.swift
//  recipe
//
//  Created by ilker on 12.12.2017.
//  Copyright © 2017 Appyist. All rights reserved.
//

import UIKit

class TableHeaderView: DesignableView, XibLoadable {
    
    
    // MARK: - UI Elements
    @IBOutlet weak var shortInfoLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Loads designed view from .xib file
        loadViewFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Loads designed view from .xib file
        loadViewFromXib()
    }
    
    func fill(with campaign: Campaign) {
        shortInfoLabel.text = campaign.companyName
        let url = URL(string: campaign.image)
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])

    }
}
