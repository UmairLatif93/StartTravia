//
//  FadeEnabledButton.swift
//  Star Travia
//
//  Created by Umair Latif on 14/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class FadeEnabledButton : UIButton {
    
    override var isEnabled: Bool {
        
        didSet {
            
            if isEnabled {
                
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 1.0
                }
            }
            else {
                
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 0.5
            }
        }
    }

    }
}
