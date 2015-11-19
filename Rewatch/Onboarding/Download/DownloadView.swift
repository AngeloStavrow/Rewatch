//
//  DownloadView.swift
//  Rewatch
//
//  Created by Romain Pouclet on 2015-11-04.
//  Copyright © 2015 Perfectly-Cooked. All rights reserved.
//

import UIKit

class DownloadView: UIView {

    @IBOutlet weak var statusLabel: UILabel! {
        didSet {
            statusLabel.font = Stylesheet.statusFont
            statusLabel.textColor = Stylesheet.statusTextColor
        }
    }
    
    @IBOutlet weak var animationView: DownloadAnimationView!
}
