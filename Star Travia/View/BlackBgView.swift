//
//  BlackBgView.swift
//  Star Travia
//
//  Created by Umair Latif on 09/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class BlackBgView: UIView {
    
    override func awakeFromNib() {
        
        layer.backgroundColor = BlackBG
        layer.cornerRadius = 10
    }
}

class BlackBgButton: UIButton {
    
    override func awakeFromNib() {
        
        layer.backgroundColor = BlackBG
        layer.cornerRadius = 10
    }
}
