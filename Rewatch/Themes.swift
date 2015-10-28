//
//  Themes.swift
//  Rewatch
//
//  Created by Romain Pouclet on 2015-10-27.
//  Copyright © 2015 Perfectly-Cooked. All rights reserved.
//

import UIKit

protocol Theme {
    var backgroundColor: UIColor { get }
    var showNameColor: UIColor { get }
    var episodeNumberColor: UIColor { get }
    var seasonNumberColor: UIColor { get }
    var episodeTitleColor: UIColor { get }
    var summaryColor: UIColor { get }
    var noteColor: UIColor { get }
    var sharingTintColor: UIColor { get }
}

struct RedTheme: Theme {
    var backgroundColor: UIColor { get { return UIColor(rgba: "#F74E40") } }
    var showNameColor: UIColor { get { return .whiteColor() } }
    var episodeNumberColor: UIColor { get { return .blackColor() } }
    var seasonNumberColor: UIColor { get { return .blackColor() } }
    var episodeTitleColor: UIColor { get { return .whiteColor() } }
    var summaryColor: UIColor { get { return .whiteColor() } }
    var noteColor: UIColor { get { return .redColor() } }
    var sharingTintColor: UIColor  { get { return .redColor() } }
}